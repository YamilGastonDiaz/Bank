package servlet;

import java.io.IOException;
import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.Year;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Validacion.Validaciones;
import entidad.Cliente;
import entidad.Cuenta;
import entidad.Prestamo;
import excepcion.FechaInvalidaException;
import negocio.negocioCuenta;
import negocio.negocioPrestamo;
import negocioImpl.negocioCuentaImpl;
import negocioImpl.negocioPrestamoImpl;

/**
 * Servlet implementation class ReportesServlet
 */
@WebServlet("/ReportesServlet")
public class ReportesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ReportesServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		negocioCuenta cuentaNegocio = new negocioCuentaImpl();
		
		
		int cuentasActivas = 0;
        int cuentasActivadas = 0;
        int cuentasInactivadas = 0;
        float porcCuentasActivas = 100;
        float porcCuentasInactivas = 100;
        
        List<Cliente> listaClientes = new ArrayList<>();
        
        List<Cuenta> listaCuentas = cuentaNegocio.readAll();                
        ListIterator<Cuenta> lista = listaCuentas.listIterator();
        
        int clientesActivos = 0;
        
    
        
        LocalDate fechaHasta = LocalDate.now();
        LocalDate fechaInicio = Year.of(fechaHasta.getYear()).atDay(1);
        
        
        
        boolean VerificarInput = true;

        
        if(request.getParameter("btnfiltrar")!=null)
        {	
        	String fechaInicioStr = request.getParameter("fechaInicio");
            String fechaHastaStr = request.getParameter("fechaHasta");
             
            try {
				if(Validaciones.Verificarfecha(fechaInicioStr) && Validaciones.Verificarfecha(fechaHastaStr))
				{	
						fechaInicio = LocalDate.parse(fechaInicioStr);
				    	fechaHasta = LocalDate.parse(fechaHastaStr); 
					
				    if(fechaHasta.isBefore(fechaInicio))
					{
						VerificarInput = false;
						fechaHasta = LocalDate.now();
				        fechaInicio = Year.of(fechaHasta.getYear()).atDay(1);
					}
				}
				else
				{
					 VerificarInput = false;
				}
			} catch (FechaInvalidaException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				VerificarInput = false;
			}
        
        }
        
        while(lista.hasNext())
        {	
        	Cuenta cuenta = lista.next();
        	Cliente cliente = cuenta.getCliente();
        	listaClientes.add(cliente);         	
        	{	
        		if(cuenta.Estado())
        		{
        			cuentasActivas += 1;
        			if(!cuenta.getFechaCreacion().isBefore(fechaInicio) && !cuenta.getFechaCreacion().isAfter(fechaHasta))
        			{
        				{
        					cuentasActivadas +=1;
        				}
        			}
        		}
        		else
        		{
        			if(cuenta.getFechaBaja() != null)
            		{
                		if(!cuenta.getFechaBaja().isBefore(fechaInicio) && !cuenta.getFechaBaja().isAfter(fechaHasta))
                    	{	
                    		{
                    			cuentasInactivadas +=1;;
                    		}	
                    	}
            		}
        		}	
        	}
           	 	
        }	
        
        
    	listaClientes = clientesUnicos(listaClientes);
		ListIterator<Cliente> listaC = listaClientes.listIterator();

		while(listaC.hasNext())
	        {
	        	Cliente Cliente = listaC.next();
	        	if(Cliente.Estado())
	        	{
	        		clientesActivos +=1;
	        	}
	        }

        

		
		if(cuentasActivadas == 0)
		{
			porcCuentasActivas = 0;				
		} 
		else 
		{
			if (cuentasInactivadas == 0)
			{
				 porcCuentasInactivas = 0;
			}
			else
			{				
				porcCuentasActivas =  ((float)cuentasActivadas/(cuentasActivadas+cuentasInactivadas))*100;
		        porcCuentasInactivas =  ((float)cuentasInactivadas/(cuentasActivadas+cuentasInactivadas))*100;	
			}			
		}
		
		List<Prestamo> prestamos = ListPrestamosPeriodo(fechaInicio, fechaHasta);
		int[] meses = contarMeses(prestamos);	
		
		int PrestAprobados=0;
		int PrestRechazados=0;
		float PorcPrestAprobados = 100;
		float PorcPrestRechazados = 100;
		
		if(prestamos!=null)
		{
			for (Prestamo prestamo : prestamos) 
			{
				if(prestamo.isEstado())
				{
					if(prestamo.isAprobado())
					{
						PrestAprobados++;
					}
					if(!prestamo.isAprobado())
					{
						PrestRechazados++;
					}
				}	
			}
				
		}
		
		if(PrestAprobados == 0)
		{
			PorcPrestAprobados = 0;				
		} 
		else 
		{
			if (PrestRechazados == 0)
			{
				PorcPrestRechazados = 0;
			}
			else
			{				
				PorcPrestAprobados =  ((float)PrestAprobados/(PrestAprobados+PrestRechazados))*100;
				PorcPrestRechazados =  ((float)PrestRechazados/(PrestAprobados+PrestRechazados))*100;	
			}			
		}
		
		double gananciaPrestamos = obtGananciaPrestamo(prestamos);		
		DecimalFormat df = new DecimalFormat("#.00");
		String gananciaPrestamosString = df.format(gananciaPrestamos);
		
		int totalPrestamos = PrestRechazados + PrestAprobados;
		
		request.setAttribute("gananciaPrestamosString", gananciaPrestamosString);	
		request.setAttribute("meses", meses);
		request.setAttribute("PrestAprobados", PrestAprobados);
		request.setAttribute("totalPrestamos", totalPrestamos);
		request.setAttribute("PorcPrestAprobados", PorcPrestAprobados);
		request.setAttribute("PorcPrestRechazados", PorcPrestRechazados);
		
		

        request.setAttribute("porcCuentasActivas", porcCuentasActivas);
        request.setAttribute("porcCuentasInactivas", porcCuentasInactivas);
        request.setAttribute("cuentasActivadas", cuentasActivadas);
        request.setAttribute("cuentasInactivadas", cuentasInactivadas);
		request.setAttribute("cuentasActivas", cuentasActivas);
		
		
		//Request Fecha
		request.setAttribute("fechaHasta", fechaHasta.toString());
        request.setAttribute("fechaInicio", fechaInicio.toString());

		
		
		request.setAttribute("clientesActivos", clientesActivos);
		
	    request.setAttribute("VerificarImput", VerificarInput);
	    
		
		
		
		RequestDispatcher rd = request.getRequestDispatcher("Reportes.jsp"); 
		rd.forward(request, response);
		response.getWriter().append("Served at: ").append(request.getContextPath());
        
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	// Guardar cantidad de prestamos en meses solictados
	private int[] contarMeses(List<Prestamo> prestamos) {

		int[] meses = new int[12];
		if (prestamos == null || prestamos.isEmpty()) {
			return meses;
		}

		for (Prestamo prestamo : prestamos) {

			LocalDate fecha = prestamo.getFecha();
			if (fecha != null) {
				int indiceMes = fecha.getMonthValue() - 1;
				meses[indiceMes]++;
			}
		}
		return meses;
	}

	// Devolver clientes unicos
	public List<Cliente> clientesUnicos(List<Cliente> listaClientes) {
		Set<Cliente> clientesUnicosSet = new HashSet<>(listaClientes);
		List<Cliente> listaClientesUnicos = new ArrayList<>(clientesUnicosSet);
		return listaClientesUnicos;
	}

	// Cargar prestamos

	private List<Prestamo> ListPrestamosPeriodo(LocalDate inicio, LocalDate fin) {
		negocioPrestamo prestamosNegoio = new negocioPrestamoImpl();

		List<Prestamo> lista = prestamosNegoio.readAll();
		Iterator<Prestamo> listaP = lista.iterator();
		List<Prestamo> listaDevolver = new ArrayList<>();

		Prestamo prestamo = new Prestamo();
		while (listaP.hasNext()) {
			prestamo = listaP.next();
			if (!prestamo.getFecha().isBefore(inicio) && !prestamo.getFecha().isAfter(fin)) {
				listaDevolver.add(prestamo);
			}

		}
		return listaDevolver;

	}

	private double obtGananciaPrestamo(List<Prestamo> prestamos) {

		double ganancia = 0;
		if (prestamos == null || prestamos.isEmpty()) {
			return ganancia;
		}

		for (Prestamo prestamo : prestamos) {
			if (prestamo.isAprobado()) {
				ganancia += (prestamo.getImporteMensual() * prestamo.getCuotas()) - prestamo.getImportePedido();
			}
		}
		return ganancia;
	}
}
