package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidad.Cuota;
import entidad.Movimiento;
import entidad.TipoDeMovimiento;
import negocioImpl.negocioCuotaImpl;
import negocioImpl.negocioMovimientoImpl;

@WebServlet("/ProcesarPagoServlet")
public class ProcesarPagoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idCuota = Integer.parseInt(request.getParameter("idCuota"));
        int idPrestamo = Integer.parseInt(request.getParameter("idPrestamo"));
        String numCuentaOrigen = request.getParameter("numCuentaOrigen");
        
        negocioCuotaImpl cuotaNegocio = new negocioCuotaImpl();
        boolean exito = cuotaNegocio.pagarCuota(idCuota, numCuentaOrigen);
        
        if (exito) {
        	negocioMovimientoImpl negocioMovimientoImpl = new negocioMovimientoImpl();
        	Cuota cuotaPagada = cuotaNegocio.readOne(idCuota);
        	
        	if(cuotaPagada != null)
        	{
        		Movimiento mov = new Movimiento(
        				"Movimiento Pago préstamo (cuota " + cuotaPagada.getNumCuota() + ")",
        				cuotaPagada.getMonto(),
        				new TipoDeMovimiento((short)7, "Pago Cuota Prestamo"),
        				numCuentaOrigen
        				);
        		negocioMovimientoImpl.Insert(mov);
        	}
        	
            request.getSession().setAttribute("mensajeExito", "El pago de la cuota se realizo exitosamente!");
        } else {
            request.getSession().setAttribute("mensajeError", "No se pudo procesar el pago. Verifique el saldo de su cuenta.");
        }     
        response.sendRedirect("DetallePrestamoServlet?idPrestamo=" + idPrestamo);
    }
}