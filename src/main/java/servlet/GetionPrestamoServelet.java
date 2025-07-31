package servlet;

import java.io.IOException;
import java.text.NumberFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidad.Cuenta;
import entidad.Usuario;
import negocioImpl.negocioCuentaImpl;




@WebServlet("/GetionPrestamoServelet")
public class GetionPrestamoServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public GetionPrestamoServelet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 HttpSession session = request.getSession(false); // no crea nueva sesión si no existe
		 negocioCuentaImpl negocioCuentaImpl = new negocioCuentaImpl();
		 
		    if (session != null) {
		    	Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");

		        if (usuario != null) {
		            int idCliente = usuario.getIdcliente();
		            List<Cuenta> listCuentas = negocioCuentaImpl.readAllByClienteId(idCliente);
		            
		            request.setAttribute("cuentasTotal", listCuentas);
		        }
		    }
		    
		    RequestDispatcher rd = request.getRequestDispatcher("NuevoPrestamo.jsp");
			rd.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String cuota = request.getParameter("cantidadCuotas");
	    String importePedido = request.getParameter("txtMonto");
	    LocalDate fechaPrimerVencimiento = LocalDate.now().plusMonths(1);
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

	    double monto = 0;
	    int cuotas = 0;
	    int tna = 28;

	    HttpSession session = request.getSession(false);
	    if (session != null) {
	        Usuario usuario = (Usuario) session.getAttribute("usuario");
	        if (usuario != null) {
	        	negocioCuentaImpl negocioCuentaImpl = new negocioCuentaImpl();
	            List<Cuenta> cuentas = negocioCuentaImpl.readAllByClienteId(usuario.getIdcliente());
	            request.setAttribute("cuentasTotal", cuentas);
	        }
	    }

	    try {
	        monto = Double.parseDouble(importePedido);
	        cuotas = Integer.parseInt(cuota);
	    } catch (NumberFormatException e) {
	        request.setAttribute("error", "Datos inválidos en monto o cuotas.");
	        request.getRequestDispatcher("NuevoPrestamo.jsp").forward(request, response);
	        return;
	    }

	    double cuotaMensual = calcularCuota(monto, tna, cuotas);
	    double montoTotal = cuotaMensual * cuotas;

	    NumberFormat formatoMoneda = NumberFormat.getCurrencyInstance(Locale.forLanguageTag("es-AR"));
	    String cuotaMensualFormateada = formatoMoneda.format(cuotaMensual);
	    String montoTotalFormateado = formatoMoneda.format(montoTotal);
	    String montoPedidoFormateado = formatoMoneda.format(monto);

	    request.setAttribute("monto", monto);
	    request.setAttribute("tna", tna);
	    request.setAttribute("cuotas", cuotas);
	    request.setAttribute("cuotaMensual", cuotaMensual); 
	    request.setAttribute("montoTotal", montoTotal); 
	   
	    request.setAttribute("montoPedidoFormateado", montoPedidoFormateado);
	    request.setAttribute("cuotaMensualFormateada", cuotaMensualFormateada);
	    request.setAttribute("montoTotalFormateado", montoTotalFormateado);
	    request.setAttribute("primerVencimiento", fechaPrimerVencimiento.format(formatter));

	    RequestDispatcher rd = request.getRequestDispatcher("NuevoPrestamo.jsp");
	    rd.forward(request, response);
	}


	
	public static double calcularCuota(double monto, double tasaAnual, int plazoMeses) {
	    double tasaMensual = tasaAnual / 12 / 100;  
	    double interesPorMes = monto * tasaMensual; 
	    double amortizacion = monto / plazoMeses;  
	    return amortizacion + interesPorMes; 
	}

}
