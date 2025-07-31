package servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import conexion.Conexion;
import daoImpl.CuentaImpl;
import daoImpl.CuotaImpl;
import daoImpl.PrestamoImpl;
import entidad.Movimiento;
import entidad.Prestamo;
import entidad.TipoDeMovimiento;
import negocioImpl.negocioMovimientoImpl;
import negocioImpl.negocioPrestamoImpl;


@WebServlet("/AutorizacionPrestamoServlet")
public class AutorizacionPrestamoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AutorizacionPrestamoServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        String idPrest = request.getParameter("idPrestamo");

        if (idPrest == null || accion == null) {
            request.setAttribute("mensajeError", "Faltan parámetros requeridos.");
            forwardToListar(request, response);
            return;
        }

        int idPrestamo;
        try {
            idPrestamo = Integer.parseInt(idPrest);
        } catch (NumberFormatException e) {
            request.setAttribute("mensajeError", "El ID del préstamo no es válido.");
            forwardToListar(request, response);
            return;
        }

        Connection conn = Conexion.getConexion().getSQLConexion();
        PrestamoImpl prestamoDao = new PrestamoImpl();
        negocioPrestamoImpl negocioPrestamoImpl = new negocioPrestamoImpl();
        CuotaImpl cuotaDao = new CuotaImpl();

        Prestamo prestamo = negocioPrestamoImpl.readById(idPrestamo);
        if (prestamo == null) {
            request.setAttribute("mensajeError", "El préstamo no existe.");
            forwardToListar(request, response);
            return;
        }

        try {
            conn.setAutoCommit(false); 

            if (accion.equals("aprobar")) {
                prestamo.setEstado(true);
                prestamo.setAprobado(true);
                prestamo.setFinalizado(false);

                boolean actualizado = prestamoDao.actualizarEstado(prestamo);
                if (!actualizado) {
                    conn.rollback();
                    request.setAttribute("mensajeError", "Error al actualizar el préstamo.");
                    forwardToListar(request, response);
                    return;
                }

                boolean cuotasOk = cuotaDao.generarCuotas(prestamo);
                if (!cuotasOk) {
                    conn.rollback();
                    request.setAttribute("mensajeError", "Error al generar las cuotas.");
                    forwardToListar(request, response);
                    return;
                }

                negocioMovimientoImpl negocioMovimientoImpl = new negocioMovimientoImpl();
                Movimiento mov = new Movimiento(
                		"Movimiento Acreditación préstamo",
                		prestamo.getImportePedido(),
                		new TipoDeMovimiento((short)6, "Acreditación Prestamo"),
                		prestamo.getNumDeCuenta()
                		);

                int idMov = negocioMovimientoImpl.Insert(mov);
                if (idMov <= 0) {
                    conn.rollback();
                    request.setAttribute("mensajeError", "Error al registrar el movimiento de acreditación.");
                    forwardToListar(request, response);
                    return;
                }

                CuentaImpl cuentaDao = new CuentaImpl();
                boolean saldoOk = cuentaDao.acreditarSaldo(prestamo.getNumDeCuenta(), prestamo.getImportePedido());
                if (!saldoOk) {
                    conn.rollback();
                    request.setAttribute("mensajeError", "Error al acreditar el saldo en la cuenta destino.");
                    forwardToListar(request, response);
                    return;
                }

                conn.commit();
                request.setAttribute("mensajeExito", "Préstamo aprobado correctamente.");
                forwardToListar(request, response);

            } else if (accion.equals("rechazar")) {
                prestamo.setEstado(true);
                prestamo.setAprobado(false);
                prestamo.setFinalizado(false);

                boolean actualizado = prestamoDao.actualizarEstado(prestamo);
                if (actualizado) {
                    conn.commit();
                    request.setAttribute("mensajeExito", "Préstamo rechazado correctamente.");
                } else {
                    conn.rollback();
                    request.setAttribute("mensajeError", "Error al rechazar el préstamo.");
                }
                forwardToListar(request, response);

            } else {
                request.setAttribute("mensajeError", "Acción no reconocida.");
                forwardToListar(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            request.setAttribute("mensajeError", "Ocurrió un error inesperado.");
            forwardToListar(request, response);

        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private void forwardToListar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("ListarPrestamoServlet");
        rd.forward(request, response);
    }
}
