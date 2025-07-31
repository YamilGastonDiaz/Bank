package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import negocioImpl.negocioCuentaImpl;


@WebServlet("/EliminarCuentaServlet")
public class EliminarCuentaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public EliminarCuentaServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String numCuenta = request.getParameter("numCuenta");

		    if (numCuenta != null && !numCuenta.isEmpty()) {
		        negocioCuentaImpl negocioCuentaImpl = new negocioCuentaImpl();
		        negocioCuentaImpl.darDeBajaCuenta(numCuenta);
		    }

		    response.sendRedirect("ListarCuentasServlet");
	}

}
