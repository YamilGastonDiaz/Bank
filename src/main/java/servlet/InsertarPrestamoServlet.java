package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidad.Prestamo;
import negocioImpl.negocioPrestamoImpl;


@WebServlet("/InsertarPrestamoServlet")
public class InsertarPrestamoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public InsertarPrestamoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String numCuenta = request.getParameter("numCuenta");
	    String montoPedido = request.getParameter("monto");
	    String cantCuotas = request.getParameter("cuotas");
	    String cuotaMensualStr = request.getParameter("cuotaMensual");

	    HttpSession session = request.getSession();

	    try {
	        double monto = Double.parseDouble(montoPedido);
	        short cuotas = Short.parseShort(cantCuotas);
	        double importeMensual = Double.parseDouble(cuotaMensualStr);

	        Prestamo nuevo = new Prestamo(numCuenta, monto, cuotas, importeMensual);

	        negocioPrestamoImpl negocioPrestamoImpl = new negocioPrestamoImpl();
	        boolean insertOK = negocioPrestamoImpl.insert(nuevo);

	        if (insertOK) {
	            session.setAttribute("toastExito", "Préstamo solicitado con éxito.");
	        } else {
	            session.setAttribute("toastError", "Error al registrar el préstamo.");
	        }

	    } catch (NumberFormatException e) {
	        session.setAttribute("toastError", "Error: datos inválidos en la solicitud.");
	    }

	    response.sendRedirect("MisPrestamosServlet");
	}

}
