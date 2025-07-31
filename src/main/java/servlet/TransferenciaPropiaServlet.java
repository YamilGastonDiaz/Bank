package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidad.Cuenta;
import entidad.Transferencia;
import entidad.Usuario;
import negocioImpl.negocioCuentaImpl;
import negocioImpl.negocioTransferenciaImpl;


@WebServlet("/TransferenciaPropiaServlet")
public class TransferenciaPropiaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public TransferenciaPropiaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 	HttpSession session = request.getSession();
		    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuario");

		    if (usuarioLogueado == null) {
		        response.sendRedirect("InicioSesion.jsp");
		        return;
		    }

		    int idCliente = usuarioLogueado.getIdcliente();

		    negocioCuentaImpl negocioCuentaImpl = new negocioImpl.negocioCuentaImpl();
		    List<Cuenta> cuentasCliente = negocioCuentaImpl.readAllByClienteId(idCliente);

		    request.setAttribute("cuentasCliente", cuentasCliente);
		    request.getRequestDispatcher("TransferenciaPropia.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
	    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuario");

	    if (usuarioLogueado == null) {
	        response.sendRedirect("InicioSesion.jsp");
	        return;
	    }

	    try {
	        String cuentaOrigen = request.getParameter("cuentaOrigen");
	        String cuentaDestino = request.getParameter("cuentaDestino");
	        String detalle = request.getParameter("detalle");
	        String montoStr = request.getParameter("monto");

	        if (cuentaOrigen == null || cuentaDestino == null || montoStr == null ||
	            cuentaOrigen.trim().isEmpty() || cuentaDestino.trim().isEmpty() || montoStr.trim().isEmpty()) {
	            response.sendRedirect("Transferencias.jsp?mensaje=error");
	            return;
	        }

	        if (cuentaOrigen.equals(cuentaDestino)) {
	            response.sendRedirect("Transferencias.jsp?mensaje=mismaCuenta");
	            return;
	        }

	        double monto = Double.parseDouble(montoStr);
	        if (monto <= 0) {
	            response.sendRedirect("Transferencias.jsp?mensaje=montoInvalido");
	            return;
	        }

	        Transferencia transferencia = new Transferencia(cuentaOrigen, cuentaDestino, monto);
	        negocioTransferenciaImpl negocioTransferenciaImpl = new negocioTransferenciaImpl();

	        boolean exito = negocioTransferenciaImpl.Insert(transferencia, detalle);

	        if (exito) {
	            response.sendRedirect("Transferencias.jsp?mensaje=ok");
	        } else {
	            response.sendRedirect("Transferencias.jsp?mensaje=error");
	        }

	    } catch (NumberFormatException e) {
	        response.sendRedirect("Transferencias.jsp?mensaje=montoInvalido");
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendRedirect("Transferencias.jsp?mensaje=error");
	    }
	}
}
