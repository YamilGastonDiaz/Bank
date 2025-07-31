package servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Validacion.Validaciones;
import entidad.Cliente;
import entidad.Cuenta;
import entidad.Movimiento;
import entidad.TipoDeCuenta;
import entidad.TipoDeMovimiento;
import excepcion.ClienteNoExisteExcepcion;
import negocioImpl.negocioCuentaImpl;
import negocioImpl.negocioMovimientoImpl;


@WebServlet("/InsertCuentasServlet")
public class InsertCuentasServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public InsertCuentasServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			negocioCuentaImpl negocioCuentaImpl = new negocioCuentaImpl();
			List<TipoDeCuenta> listaTipo = negocioCuentaImpl.readAllTipoDeCuenta();
			
			request.setAttribute("tipoCuenta", listaTipo);
			
			RequestDispatcher rd = request.getRequestDispatcher("ABMCuentas.jsp");
			rd.forward(request, response);
		} catch (Exception e) {
			e.fillInStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String dni = request.getParameter("txtDni");
	    String numCuenta = request.getParameter("txtNumeroCuenta");
	    String cbu = request.getParameter("txtCbu");
	    
	    if (dni == null || dni.trim().isEmpty() || numCuenta == null || numCuenta.trim().isEmpty() ||
	            cbu == null || cbu.trim().isEmpty()) {

	            request.setAttribute("mensajeError", "Todos los campos son obligatorios.");
	            setValoresFormularioEnRequest(request);
	            doGet(request, response);
	            return;
	        }
	    
	    if (!dni.matches("\\d{7,8}")) {
	        request.setAttribute("mensajeError", "El DNI debe contener solo números y tener entre 7 y 8 dígitos.");
	        setValoresFormularioEnRequest(request);
	        doGet(request, response);
	        return;
	    }
	    
	    
	    if (!numCuenta.matches("\\d{11,13}")) {
	        request.setAttribute("mensajeError", "El número de cuenta debe contener solo números y tener entre 11 y 13 dígitos.");
	        setValoresFormularioEnRequest(request);
	        doGet(request, response);
	        return;
	    }
	    
	    
	    if (!cbu.matches("\\d{22}")) {
	        request.setAttribute("mensajeError", "El CBU debe contener exactamente 22 dígitos numéricos.");
	        setValoresFormularioEnRequest(request);
	        doGet(request, response);
	        return;
	    }
	    
	    LocalDate fechaAlta = LocalDate.now();
	    
	    int idTipo = Integer.parseInt(request.getParameter("tipoCuenta"));

	    negocioCuentaImpl negocioCuentaImpl = new negocioCuentaImpl();

	    int idCliente = negocioCuentaImpl.buscarId(dni);
	   	    
	    try {
	        Validaciones.ClienteInexistente(idCliente); 
	    } catch (ClienteNoExisteExcepcion e) {
	        request.setAttribute("mensajeError", "El DNI no pertenece a un cliente.");
	        setValoresFormularioEnRequest(request);
	        doGet(request, response);
	        return;
	    }
	    
	    int cantCuenta = negocioCuentaImpl.cantidadCuentas(dni);
	    if (cantCuenta >= 3) {
	    	request.setAttribute("mensajeError", "No puede crear mas cuentas, 3 es el limite.");
	        doGet(request, response);
	        return;
		}

	    TipoDeCuenta tipo = new TipoDeCuenta();
	    tipo.setIdTipoCuenta((short) idTipo);

	    Cliente cliente = new Cliente();
	    cliente.setIdCliente(idCliente);

	    Cuenta cuenta = new Cuenta(numCuenta, cbu, fechaAlta, tipo, cliente);

	    boolean insertCuenta = negocioCuentaImpl.insert(cuenta);
	    if (insertCuenta) {
	    	
	    	negocioMovimientoImpl negocioMovimientoImpl = new negocioMovimientoImpl();
	    	
	    	 Movimiento movAltaCuenta = new Movimiento(
	    		        "Movimiento Alta de cuenta",
	    		        10000.00,
	    		        new TipoDeMovimiento((short)5, "Alta de Cuenta"),
	    		        numCuenta
	    		    );
	    	negocioMovimientoImpl.Insert(movAltaCuenta);
	    	 
	        request.setAttribute("mensajeExito", "Cuenta agregada correctamente.");
	    } else {
	        request.setAttribute("mensajeError", "No se pudo agregar la cuenta.");
	    }

	    doGet(request, response);
	}
	
	private void setValoresFormularioEnRequest(HttpServletRequest request) {
	    String dni = request.getParameter("txtDni");
	    String tipoCuenta = request.getParameter("tipoCuenta");
	    String numeroCuenta = request.getParameter("txtNumeroCuenta");
	    String cbu = request.getParameter("txtCbu");

	    request.setAttribute("dni", dni);
	    request.setAttribute("tipoCuentaSeleccionada", tipoCuenta);
	    request.setAttribute("numeroCuenta", numeroCuenta);
	    request.setAttribute("cbu", cbu);
	}

}
