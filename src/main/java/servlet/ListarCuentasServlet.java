package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import entidad.Cuenta;
import negocioImpl.negocioCuentaImpl; 


@WebServlet("/ListarCuentasServlet")
public class ListarCuentasServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ListarCuentasServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		negocioCuentaImpl negocioCuentaImpl = new negocioCuentaImpl();

		String filtroTipoCuenta = request.getParameter("filtroTipoCuenta");
		String filtroEstado = request.getParameter("filtroEstado");
		String filtroDni = request.getParameter("filtroDni");
		boolean btnLimpiar = request.getParameter("btnLimpiarFiltros") != null;
		

		// Filtros : "" = Todos
		if (filtroTipoCuenta == null) filtroTipoCuenta = "";
		if (filtroEstado == null) filtroEstado = "";
		if (filtroDni == null) filtroDni = "";

		List<Cuenta> listaCuentas = null;

		boolean filtrosVacios = filtroTipoCuenta.isEmpty() && filtroEstado.isEmpty() && filtroDni.isEmpty();

		if (filtrosVacios) {
		    // Si los filtros vienen vacios mostramos todo
		    listaCuentas = negocioCuentaImpl.readAll();
		} else {
		    // si ingresa algun filtro
			String query = "";
			
		    if (!filtroDni.isEmpty()) {
		        query = "dni = '" + filtroDni + "'";
		    }		    
		    if (!filtroTipoCuenta.isEmpty()) {
		    	if (!query.isEmpty()) query += " AND ";
		        query += "descTipoCuenta = '" + filtroTipoCuenta + "'";
		    }
		    if (!filtroEstado.isEmpty()) {
		    	if (!query.isEmpty()) query += " AND ";
		        int estado = "ACTIVA".equals(filtroEstado) ? 1 : 0;
		        query += "estadoCuenta = " + estado;
		    }

		    listaCuentas = negocioCuentaImpl.readAll(query.toString());
		}
		
		if (btnLimpiar) {
		    filtroTipoCuenta = "";
		    filtroEstado     = "";
		    filtroDni = "";
		    listaCuentas = negocioCuentaImpl.readAll(); 
		}

		request.setAttribute("filtroTipoCuenta", filtroTipoCuenta);
		request.setAttribute("filtroEstado", filtroEstado);
		request.setAttribute("filtroDni", filtroDni);
		request.setAttribute("listaCuentas", listaCuentas);
		

		request.getRequestDispatcher("ListaDeCuentas.jsp")
		       .forward(request, response);
	
	}
	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

}
