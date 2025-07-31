<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.util.List, entidad.Cuenta, entidad.Movimiento" %>
<%@ include file="fragmentos/VerificarSesion.jspf" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>


<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>Home Banking - Cuentas y Movimientos</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous" />
    <!-- Bootstrap Iconos -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- Hoja de estilos -->
    <link rel="stylesheet" href="Styles.css" type="text/css" />
    <!-- Favicon  -->
    <link rel="icon" href="assets/bank.png" type="image/png" />
    <!-- jQuery y DataTables -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.min.css">
	<script src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>
 

    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background-image: url('assets/bg1.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        .container {
            flex: 1;
            background-color: rgba(255, 255, 255, 0.9);
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,0,0,0.3);
            margin-top: 2rem;
            margin-bottom: 2rem;
        }
        
        form.mb-4 select#cuentaSelect {
 		   max-width: 300px;
		}
		
		form.mb-4 button {
    		margin-left: 10px;
		}
        
        h2 {
            font-weight: 700;
            margin-bottom: 1.5rem;
        }
        h2 i{
        	margin-right: 8px;
  			font-size: 1.4rem;
  			vertical-align: middle;
        }
        
        .no-data-message {
    		font-size: 1.1rem;
    		color: #6c757d;
    		font-style: italic;
		}

        table th, table td {
            vertical-align: middle !important;
        }
        
        table.table tbody tr:ntn-child(odd){
        	background-color: #f9f9f9;
        }
        
        table.table tbody tr:hover {
    		background-color: #d1e7dd !important;
		}
    </style>
</head>
<body>
  <jsp:include page="Nav.jsp" />
<div class="container-fluid container">

    <h2 class="text-center text-primary mt-5">
        <i class="bi bi-credit-card"></i> Cuentas
    </h2>
	
	<p class="text-muted text-center">
    	A continuación se muestra un resumen de todas tus cuentas activas. Puedes consultar el tipo de cuenta, su número, CBU y el saldo actual disponible.
	</p>

	<div class="table-responsive">
    <table class="table table-bordered table-striped table-hover align-middle text-center">
        <thead class="bg-primary text-white">
            <tr>
                <th ><i class="bi bi-credit-card"></i> Número</th>
                <th ><i class="bi bi-card-list"></i> Tipo</th>
                <th ><i class="bi bi-card-list"></i> CBU</th>
                <th ><i class="bi bi-currency-dollar"></i> Saldo</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Cuenta> cuentas = (List<Cuenta>) request.getAttribute("cuentas");
                if (cuentas != null && !cuentas.isEmpty()) {
                    for (Cuenta c : cuentas) {
            %>
                <tr>
                    <td><%= c.getNumDeCuenta() %></td>
                    <td><%= c.getTipoCuenta().getDescripcion() %></td>
                    <td><%= c.getCbu() %></td>
                    <td>$ <%= String.format("%.2f", c.getSaldo() != null ? c.getSaldo() : 0.0) %></td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
    <td colspan="4" class="text-center text-muted no-data-message py-3">
        <i class="bi bi-info-circle"></i> No hay cuentas para mostrar
    </td>
</tr>

            <%
                }
            %>
        </tbody>
    </table>
	</div>
	
	<p class="text-muted text-center">
    Para consultar los movimientos de una cuenta específica, selecciona una de tus cuentas en el siguiente menú desplegable y presiona "Buscar".
	</p>
	
	
    <!-- Formulario para filtrar movimientos -->
    <form method="post" action="MovimientoServlet" class="mb-4" onsubmit="return validarCuentaSeleccionada()">
        <input type="hidden" name="operacion" value="Movimientos" />
        <label for="cuentaSelect">Filtrar por cuenta:</label>
        <select name="cuenta" id="cuentaSelect" class="form-select w-auto d-inline-block">
            <option value="">-- Seleccione una cuenta --</option>
            <% 
            String cuentaSel = (String) request.getAttribute("cuentaSeleccionada");
                if (cuentas != null) {
                    for (Cuenta c : cuentas) { 
            %>
                <option value="<%= c.getNumDeCuenta() %>" 
                    <%= (cuentaSel != null && cuentaSel.equals(c.getNumDeCuenta())) ? "selected" : "" %>>
                    <%= c.getNumDeCuenta() %> - <%= c.getTipoCuenta() %>
                </option>
            <% 
                    } 
                } 
            %>
        </select>
        <button type="submit" class="btn btn-primary">Buscar</button>
    </form>
    

    <h2 class="text-center text-success mt-5">
        <i class="bi bi-arrow-repeat"></i> Movimientos
    </h2>
    
    <p class="text-muted text-center">
    	Aquí puedes ver el historial de movimientos de la cuenta seleccionada. La información incluye la fecha del movimiento, el monto involucrado y su tipo.
	</p>
    
    
    <div class="table-responsive">
    <table id="MovimientosTable" class="table table-bordered table-striped table-hover align-middle text-center">
        <thead class="bg-success text-white">
            <tr>
                <th class="text-center"><i class="bi bi-calendar-event"></i> Fecha</th>
                <th class="text-center"><i class="bi bi-cash-stack"></i> Monto</th>
                <th class="text-center"><i class="bi bi-tag"></i> Tipo de Movimiento</th>
            </tr>
        </thead>
        <tbody>
			<%
    			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
			%>
			
            <%
                List<Movimiento> movimientos = (List<Movimiento>) request.getAttribute("movimientos");
                if (movimientos != null && !movimientos.isEmpty()) {
                    for (Movimiento m : movimientos) {
                    	 LocalDate fecha = m.getFecha();
            %>
            

            
                <tr>
                    <td><%= fecha != null ? fecha.format(formatter) : "" %></td>
                    <td>$ <%= String.format("%.2f", m.getImporte() != null ? m.getImporte() : 0.0) %></td>
                    <td><%= m.getTipoMovimiento() != null ? m.getTipoMovimiento().getDescripcion() : "" %></td>
                </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>
	</div>
    

</div>

<!-- Bootstrap JS y Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj"
        crossorigin="anonymous"></script>

<script type="text/javascript">
function validarCuentaSeleccionada() {
    const cuenta = document.getElementById('cuentaSelect').value;
    if (!cuenta) {
        alert("Por favor seleccione una cuenta para filtrar los movimientos.");
        return false;
    }
    return true;
}

</script>
             
<script>
		$(document)
				.ready(
						function() {
							$('#MovimientosTable')
									.DataTable(
											{
												"paging" : true,
												"pageLength" : 10,
												"lengthChange" : false,
												"searching" : true,
												"ordering" : true,
												"info" : true,
												"autoWidth" : false,
												"scrollX" : true,
												"language" : {
													"url" : "https://cdn.datatables.net/plug-ins/1.13.1/i18n/es-ES.json",
													"emptyTable": "No hay movimientos para mostrar"
												},
												"destroy": true
											});
						});
	</script>


</body>
  <jsp:include page="Footer.html" />
</html>
