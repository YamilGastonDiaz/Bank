package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Validacion.Validaciones;
import entidad.Cuenta;
import entidad.Transferencia;
import entidad.Usuario;
import excepcion.SaldoInsuficienteException;
import negocioImpl.negocioCuentaImpl;
import negocioImpl.negocioTransferenciaImpl;

@WebServlet("/TransferenciaCbuServlet")
public class TransferenciaCbuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public TransferenciaCbuServlet() {
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

		    negocioCuentaImpl negocioCuentaImpl = new negocioCuentaImpl();
		    List<Cuenta> cuentasCliente = negocioCuentaImpl.readAllByClienteId(idCliente);

		    request.setAttribute("cuentasCliente", cuentasCliente);
		    request.getRequestDispatcher("TransferenciaCbu.jsp").forward(request, response);
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
	        String cbuDestino = request.getParameter("cbu");
	        String detalle = request.getParameter("detalle");
	        String montoStr = request.getParameter("monto");
	        
	        if(!Validaciones.existeCuil(cbuDestino)) 
	        {
	        	response.sendRedirect("Transferencias.jsp?mensaje=errorCbu");
	            return;
	        }
	        
	        if (cuentaOrigen == null || cbuDestino == null || montoStr == null ||
	            cuentaOrigen.trim().isEmpty() || cbuDestino.trim().isEmpty() || montoStr.trim().isEmpty()) {
	            response.sendRedirect("Transferencias.jsp?mensaje=error");
	            return;
	        }

	        double monto = Double.parseDouble(montoStr);
	        
	        try {
	            Validaciones.FaltaSaldo(monto);
	        } catch (NumberFormatException e) {
	            response.sendRedirect("Transferencias.jsp?mensaje=formatoMontoInvalido");
	        } catch (SaldoInsuficienteException e) {
	            response.sendRedirect("Transferencias.jsp?mensaje=montoInvalido");
	        } 
	        	    
	        negocioCuentaImpl negocioCuentaImpl = new negocioCuentaImpl();
	        Cuenta cuentaDestino = negocioCuentaImpl.obtenerCuentaPorCBU(cbuDestino);

	        if (cuentaDestino == null) {
	            response.sendRedirect("Transferencias.jsp?mensaje=cbuInvalido");
	            return;
	        }

	        String numCuentaDestino = cuentaDestino.getNumDeCuenta();

	        List<Cuenta> cuentasCliente = negocioCuentaImpl.readAllByClienteId(usuarioLogueado.getIdcliente());

	        boolean esCuentaPropia = cuentasCliente.stream()
	            .anyMatch(c -> c.getNumDeCuenta().equals(numCuentaDestino));

	        if (esCuentaPropia) {
	            response.sendRedirect("Transferencias.jsp?mensaje=cbuPropio");
	            return;
	        }


	        if (cuentaOrigen.equals(numCuentaDestino)) {
	            response.sendRedirect("Transferencias.jsp?mensaje=mismaCuenta");
	            return;
	        }

	        Transferencia transferencia = new Transferencia(cuentaOrigen, numCuentaDestino, monto);
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
