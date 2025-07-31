package servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidad.Prestamo;
import negocioImpl.negocioPrestamoImpl;


@WebServlet("/ListarPrestamoServlet")
public class ListarPrestamoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ListarPrestamoServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		negocioPrestamoImpl negocioPrestamoImpl = new negocioPrestamoImpl();
	    List<Prestamo> prestamos = negocioPrestamoImpl.readAll();
	    List<Prestamo> filtrados = new ArrayList<>();

	    String estadoFiltro = request.getParameter("estado");
	    String cuotasParam = request.getParameter("cuotas");
	    String fechaDesdeParam = request.getParameter("fechaDesde");
	    String fechaHastaParam = request.getParameter("fechaHasta");
	    String clienteFiltro = request.getParameter("cliente");

	    boolean sinFiltros = (estadoFiltro == null && cuotasParam == null &&
	                          fechaDesdeParam == null && fechaHastaParam == null &&
	                          (clienteFiltro == null || clienteFiltro.isEmpty()));

	    LocalDate hoy = LocalDate.now();
	    LocalDate inicioMesActual = hoy.withDayOfMonth(1);
	    LocalDate inicioDosMesesAntes = inicioMesActual.minusMonths(2);

	    LocalDate fechaDesde = (fechaDesdeParam != null && !fechaDesdeParam.isEmpty())
	                            ? LocalDate.parse(fechaDesdeParam)
	                            : (sinFiltros ? inicioDosMesesAntes : null);

	    LocalDate fechaHasta = (fechaHastaParam != null && !fechaHastaParam.isEmpty())
	                            ? LocalDate.parse(fechaHastaParam)
	                            : (sinFiltros ? hoy : null);

	    boolean aplicarFiltroEstado = true;

	    if (estadoFiltro == null) {
	        estadoFiltro = "pendiente"; // por defecto filtra pendientes
	    } else if (estadoFiltro.isEmpty()) {
	        aplicarFiltroEstado = false; // si eligio el filtro "Todos"
	    }

	    Integer cuotasSeleccionadas = null;
	    if (cuotasParam != null && !cuotasParam.isEmpty()) {
	        try {
	            cuotasSeleccionadas = Integer.parseInt(cuotasParam);
	        } catch (NumberFormatException e) {
	            // ignorar
	        }
	    }

	    for (Prestamo p : prestamos) {
	    	boolean pasaEstado = !aplicarFiltroEstado || switch (estadoFiltro) {
	        case "pendiente" -> !p.isEstado();
	        case "activo" -> p.isEstado() && p.isAprobado() && !p.isFinalizado();
	        case "rechazado" -> p.isEstado() && !p.isAprobado();
	        case "finalizado" -> p.isFinalizado();
	        default -> true;
	        };

	        boolean pasaCuotas = cuotasSeleccionadas == null || p.getCuotas() == cuotasSeleccionadas;
	        boolean pasaFechaDesde = fechaDesde == null || !p.getFecha().isBefore(fechaDesde);
	        boolean pasaFechaHasta = fechaHasta == null || !p.getFecha().isAfter(fechaHasta);
	        boolean pasaCliente = clienteFiltro == null || clienteFiltro.isEmpty() ||
	                              (p.getNombreUsuario() != null && p.getNombreUsuario().toLowerCase().contains(clienteFiltro.toLowerCase()));

	        if (pasaEstado && pasaCuotas && pasaFechaDesde && pasaFechaHasta && pasaCliente) {
	            filtrados.add(p);
	        }
	    }

	    // ordenar primero por estado, luego por fecha descendente
	    filtrados.sort((p1, p2) -> {
	        int estado1 = (!p1.isEstado()) ? 0 : 1;
	        int estado2 = (!p2.isEstado()) ? 0 : 1;
	        if (estado1 != estado2) return Integer.compare(estado1, estado2);
	        return p2.getFecha().compareTo(p1.getFecha());
	    });

	    request.setAttribute("listaPrestamos", filtrados);
	    request.setAttribute("estadoSeleccionado", estadoFiltro);
	    request.setAttribute("cuotasSeleccionadas", cuotasParam);
	    request.setAttribute("fechaDesdeSeleccionada", (fechaDesde != null ? fechaDesde.toString() : ""));
	    request.setAttribute("fechaHastaSeleccionada", (fechaHasta != null ? fechaHasta.toString() : ""));
	    request.setAttribute("cliente", clienteFiltro);

	    RequestDispatcher rd = request.getRequestDispatcher("AutorizacionesPrestamos.jsp");
	    rd.forward(request, response);
	}



	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
