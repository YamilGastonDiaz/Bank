<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.util.List, entidad.Cuenta" %>
<%@ include file="fragmentos/VerificarSesion.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nueva Transferencia - Novabank</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
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
      h2 {
          font-weight: 700;
          margin-bottom: 1.5rem;
      }
      table th, table td {
          vertical-align: middle !important;
      }
  </style>
</head>
<body>
<jsp:include page="Nav.jsp"/> 

<%
    List<Cuenta> cuentasCliente = (List<Cuenta>) request.getAttribute("cuentasCliente");
%>

  <main class="container mt-5">
    <div class="row justify-content-center align-items-center">
      <div class="col-lg-8">
        <div class="card p-4">
          <h3 class="fw mb-4 text-center text-primary"><i class="bi bi-arrow-left-right"></i>  Transferencia a cuenta Propia </h3>
						
          <form id="formTransferencia" action="TransferenciaPropiaServlet" method="post">
			  <!-- Cuenta Origen -->
			  <div class="mb-3">
			    <label for="cuentaOrigen" class="form-label text-primary"><i class="bi bi-wallet2 me-1"></i>Cuenta Origen</label>
			    <select class="form-select" id="cuentaOrigen" name="cuentaOrigen" required>
			      <option  value="" disabled selected>Seleccionar cuenta</option>
			      <% if (cuentasCliente != null) {
			        for (Cuenta cuenta : cuentasCliente) { %>
			          <option value="<%= cuenta.getNumDeCuenta() %>" data-saldo="<%= cuenta.getSaldo() %>">
			            <%= cuenta.getTipoCuenta().getDescripcion() %> - $<%= String.format("%.2f", cuenta.getSaldo()) %>
			          </option>
			      <% }} %>
			    </select>
			  </div>
            
			  <!-- Cuenta Destino -->
			  <div class="mb-3">
			    <label for="cuentaDestino" class="form-label text-primary"><i class="bi bi-wallet2 me-1"></i>Cuenta Destino</label>
			    <select class="form-select" id="cuentaDestino" name="cuentaDestino" required>
			      <option  value="" disabled selected>Seleccionar cuenta</option>
			      <% if (cuentasCliente != null) {
			        for (Cuenta cuenta : cuentasCliente) { %>
			          <option value="<%= cuenta.getNumDeCuenta() %>">
			            <%= cuenta.getTipoCuenta().getDescripcion() %> - $<%= String.format("%.2f", cuenta.getSaldo()) %>
			          </option>
			      <% }} %>
			    </select>
			  </div>

			 <!-- Monto -->
			  <div class="mb-3">
			    <label for="monto" class="form-label text-primary"><i class="bi bi-cash-coin me-1"></i>Monto a transferir ($)</label>
			    <input type="text" class="form-control" id="monto" name="monto" placeholder="0.00" step="0.01" min="0.01" inputmode="decimal" oninput="this.value=this.value.replace(/,/g, '.').replace(/[^0-9.]/g, '').replace(/(\\..*)\\./g, '$1');" required>
			  </div>

            <!-- Detalle -->
			  <div class="mb-3">
			    <label for="detalle" class="form-label text-primary"><i class="bi bi-pencil-square me-1"></i>Detalle</label>
			    <select class="form-select" id="detalle" name="detalle" required>
				    <option value="" selected disabled>Seleccione un motivo…</option>
				    <option value="Alquiler">Alquiler</option>
				    <option value="Cuota">Cuota</option>
				    <option value="Expensa">Expensa</option>
				    <option value="Factura">Factura</option>
				    <option value="Haberes">Haberes</option>
				    <option value="Honorarios">Honorarios</option>
				    <option value="Impuestos">Impuestos</option>
				    <option value="Servicios">Pago de servicios</option>
				    <option value="Prestamo">Préstamo</option>
				    <option value="Seguros">Seguros</option>
				    <option value="Varios">Varios</option>
				  </select>
			  </div>
			  
			<!-- Mostrar mensajes -->
			<% if (request.getAttribute("mensaje") != null) { %>
			  <div class="alert alert-success mt-3"><%= request.getAttribute("mensaje") %></div>
			<% } else if (request.getAttribute("error") != null) { %>
			  <div class="alert alert-danger mt-3"><%= request.getAttribute("error") %></div>
			<% } %>

            <div class="d-flex justify-content-end gap-2">
            <a type="button" class="btn btn-outline-secondary" href="Transferencias.jsp" ><i class="bi bi-backspace"></i> Volver</a>
              <button type="reset" class="btn btn-secondary"><i class="bi bi-x-circle me-1"></i>Limpiar formulario</button>
              <button type="button" class="btn btn-primary" onclick="validarTransferencia()"><i class="bi bi-check-circle me-1"></i>Confirmar</button>
            </div>
            
            <!-- Modal de Confirmación -->
			<div class="modal fade" id="modalConfirmacion" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalConfirmacionLabel" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="modalConfirmacionLabel"><i class="bi bi-exclamation-circle text-warning me-2"></i>Confirmar transferencia</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
			      </div>			
			      <div class="modal-body">
			        ¿Estás seguro de que querés realizar esta transferencia?
			      </div>			
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><i class="bi bi-x-circle me-1"></i> Cancelar</button>
			        <button type="submit" class="btn btn-primary"><i class="bi bi-check-circle me-1"></i> Confirmar</button>
			      </div>			      
			    </div>
			  </div>
			</div>	                       
          </form>  
        </div>
      </div>
    </div>
  </main>
<jsp:include page="Footer.html" />

<div class="modal fade" id="modalAviso" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title d-flex align-items-center">
          📢​​ Aviso
        </h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
      </div>
      <div class="modal-body text-center" id="modalAvisoTexto"></div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Aceptar <i class="bi bi-hand-thumbs-up"></i></button>
      </div>
    </div>
  </div>
</div>

<script>
function showAviso(msg) {
	  document.getElementById('modalAvisoTexto').textContent = msg;
	  new bootstrap.Modal(document.getElementById('modalAviso')).show();
	}

function validarTransferencia() {
	  const cuentaOrigenSelect = document.getElementById('cuentaOrigen');
	  const cuentaDestinoSelect = document.getElementById('cuentaDestino');
	  const montoInput = document.getElementById('monto');
	  const detalleSelect = document.getElementById('detalle');

	  const cuentaOrigen = cuentaOrigenSelect.value;
	  const cuentaDestino = cuentaDestinoSelect.value;
	  const monto = parseFloat(montoInput.value.replace(',', '.'));
	  const saldoDisponible = parseFloat(cuentaOrigenSelect.selectedOptions[0]?.dataset.saldo || 0);
	  const detalle = detalleSelect.value;

	  if (!cuentaOrigen || !cuentaDestino) {
	    showAviso('Debe seleccionar cuentas válidas. ✔️​'); return;
	  }
	  if (cuentaOrigen === cuentaDestino) {
	    showAviso('No se puede transferir a la misma cuenta. ❌​'); return;
	  }
	  if (isNaN(monto) || monto <= 0) {
	    showAviso('El monto ingresado no es válido. 💲​'); return;
	  }
	  if (monto > saldoDisponible) {
	    showAviso('El monto ingresado supera el saldo disponible de la cuenta origen. 💲​'); return;
	  }
	  if (!detalle) {
	    showAviso('Debe seleccionar un motivo de transferencia. ✔️'); return;
	  }

	  // Todo OK → abrir modal de confirmación
	  new bootstrap.Modal(document.getElementById('modalConfirmacion')).show();
	}
</script>

</body>
</html>