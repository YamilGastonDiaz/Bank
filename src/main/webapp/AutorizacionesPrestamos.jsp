<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="fragmentos/VerificarSesion.jspf"%>
<%@ page import="java.util.List"%>
<%@ page import="entidad.Prestamo"%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Administración de Préstamos</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.datatables.net/2.3.2/css/dataTables.bootstrap5.min.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/2.3.2/js/dataTables.js"></script>
<script
	src="https://cdn.datatables.net/2.3.2/js/dataTables.bootstrap5.min.js"></script>
<style>
html, body {
	height: 100%;
	margin: 0;
	display: flex;
	flex-direction: column;
}

body {
	background-color: #f8f9fa;
	background-image: url('assets/bg1.jpg');
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
	flex: 1;
	overflow-x: hidden;
}

main.container-fluid {
	background-color: #ffffff;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	margin-top: 30px;
	margin-bottom: 30px;
	flex-grow: 1;
	max-width: 95%;
}

h2 {
	color: #007bff;
	margin-bottom: 20px;
}

.table-responsive {
	margin-top: 20px;
}

tfoot {
	display: table-header-group;
}

.form-label {
	font-weight: 500;
}
</style>
</head>
<body>
	<jsp:include page="Nav.jsp" />
	<main class="container-fluid d-flex flex-column flex-grow-1">
		<div class="d-flex justify-content-between align-items-center mb-4">
			<h2 class="fw-bold">
				<i class="fas fa-clipboard-check"></i> Administración de Préstamos
			</h2>
		</div>

		<!-- Filtros -->
		<form action="ListarPrestamoServlet" method="get" class="row g-3 mb-3">
			<div class="col-md-3">
				<label for="estado" class="form-label">Estado</label>
				<%
				String estadoSel = (String) request.getAttribute("estadoSeleccionado");
				if (estadoSel == null)
					estadoSel = "";
				%>
				<select name="estado" id="estado" class="form-select">
					<option value="" <%=estadoSel.equals("") ? "selected" : ""%>>Todos</option>
					<option value="pendiente"
						<%=estadoSel.equals("pendiente") ? "selected" : ""%>>Pendiente</option>
					<option value="activo"
						<%=estadoSel.equals("activo") ? "selected" : ""%>>Activo</option>
					<option value="rechazado"
						<%=estadoSel.equals("rechazado") ? "selected" : ""%>>Rechazado</option>
					<option value="finalizado"
						<%=estadoSel.equals("finalizado") ? "selected" : ""%>>Finalizado</option>
				</select>
			</div>
			<div class="col-md-2">
				<label for="fechaDesde" class="form-label">Desde</label> <input
					type="date" name="fechaDesde" class="form-control"
					value="<%=request.getAttribute("fechaDesdeSeleccionada") != null ? request.getAttribute("fechaDesdeSeleccionada") : ""%>" />
			</div>
			<div class="col-md-2">
				<label for="fechaHasta" class="form-label">Hasta</label> <input
					type="date" name="fechaHasta" class="form-control"
					value="<%=request.getAttribute("fechaHastaSeleccionada") != null ? request.getAttribute("fechaHastaSeleccionada") : ""%>" />
			</div>
			<div class="col-md-1">
				<label for="cuotas" class="form-label">Cuotas</label> <select
					name="cuotas" id="cuotas" class="form-select">
					<option value="">Todas</option>
					<option value="6">6</option>
					<option value="12">12</option>
					<option value="24">24</option>
					<option value="36">36</option>
					<option value="48">48</option>
				</select>
			</div>
			<div class="col-md-2">
				<label for="cliente" class="form-label">Cliente</label> <input
					type="text" name="cliente" id="cliente" class="form-control"
					value="<%=request.getParameter("cliente") != null ? request.getParameter("cliente") : ""%>" />
			</div>
			<div class="col-md-1 d-flex align-items-end">
				<button type="submit" class="btn btn-primary w-100">Filtrar</button>
			</div>
			<div class="col-md-1 d-flex align-items-end">
				<a href="ListarPrestamoServlet" class="btn btn-secondary w-100">Limpiar</a>
			</div>
		</form>

		<div class="table-responsive">
			<table id="prestamosTable"
				class="table table-striped table-hover w-100">
				<thead class="table-primary">
					<tr>
						<th>Cliente</th>
						<th>N° Cuenta</th>
						<th>Fecha</th>
						<th>Monto</th>
						<th>Cuota Mensual</th>
						<th>Cuotas</th>
						<th>Estado</th>
						<th>Acciones</th>
					</tr>
				</thead>
				<tbody>
					<%
					List<Prestamo> listaPrestamos = (List<Prestamo>) request.getAttribute("listaPrestamos");
					if (listaPrestamos != null) {
						for (Prestamo p : listaPrestamos) {
					%>
					<tr>
						<td><%=p.getNombreUsuario()%></td>
						<td><%=p.getNumDeCuenta()%></td>
						<td><%=p.getFecha()%></td>
						<td>$<%=String.format("%,.2f", p.getImportePedido())%></td>
						<td>$<%=String.format("%,.2f", p.getImporteMensual())%></td>
						<td><%=p.getCuotas()%></td>
						<td>
							<%
							if (!p.isEstado()) {
							%> <span class="badge bg-warning text-dark">Pendiente</span> <%
 } else if (p.isFinalizado()) {
 %> <span class="badge bg-primary">Finalizado</span> <%
 } else if (p.isAprobado()) {
 %> <span class="badge bg-success">Activo</span> <%
 } else {
 %> <span class="badge bg-danger">Rechazado</span> <%
 }
 %>
						</td>
						<td>
							<%
							if (!p.isEstado()) {
							%> <!-- Botón Aprobar -->
							<button type="button" class="btn btn-sm btn-success me-1"
								data-bs-toggle="modal"
								data-bs-target="#modalAprobar<%=p.getIdPrestamo()%>">Aprobar</button>

							<!-- Modal Aprobar -->
							<div class="modal fade" id="modalAprobar<%=p.getIdPrestamo()%>"
								tabindex="-1"
								aria-labelledby="aprobarLabel<%=p.getIdPrestamo()%>"
								aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">
										<form action="AutorizacionPrestamoServlet" method="post">
											<div class="modal-header">
												<h5 class="modal-title"
													id="aprobarLabel<%=p.getIdPrestamo()%>">Confirmar
													Aprobación</h5>
												<button type="button" class="btn-close"
													data-bs-dismiss="modal" aria-label="Cerrar"></button>
											</div>
											<div class="modal-body">
												¿Estás seguro que deseas aprobar el préstamo <strong>#<%=p.getIdPrestamo()%></strong>?
											</div>
											<div class="modal-footer">
												<input type="hidden" name="idPrestamo"
													value="<%=p.getIdPrestamo()%>"> <input
													type="hidden" name="accion" value="aprobar"> <input
													type="hidden" name="fechaDesde"
													value="<%=request.getAttribute("fechaDesdeSeleccionada")%>">
												<input type="hidden" name="fechaHasta"
													value="<%=request.getAttribute("fechaHastaSeleccionada")%>">
												<input type="hidden" name="estado" value="<%=estadoSel%>">
												<input type="hidden" name="cliente"
													value="<%=request.getAttribute("cliente") != null ? request.getAttribute("cliente") : ""%>">
												<input type="hidden" name="cuotas"
													value="<%=request.getAttribute("cuotasSeleccionadas") != null ? request.getAttribute("cuotasSeleccionadas") : ""%>">

												<button type="submit" class="btn btn-success">Sí,
													aprobar</button>
												<button type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">Cancelar</button>
											</div>
										</form>
									</div>
								</div>
							</div> <!-- Botón Rechazar -->
							<button type="button" class="btn btn-sm btn-danger"
								data-bs-toggle="modal"
								data-bs-target="#modalRechazar<%=p.getIdPrestamo()%>">Rechazar</button>

							<!-- Modal Rechazar -->
							<div class="modal fade" id="modalRechazar<%=p.getIdPrestamo()%>"
								tabindex="-1"
								aria-labelledby="rechazarLabel<%=p.getIdPrestamo()%>"
								aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">
										<form action="AutorizacionPrestamoServlet" method="post">
											<div class="modal-header">
												<h5 class="modal-title"
													id="rechazarLabel<%=p.getIdPrestamo()%>">Confirmar
													Rechazo</h5>
												<button type="button" class="btn-close"
													data-bs-dismiss="modal" aria-label="Cerrar"></button>
											</div>
											<div class="modal-body">
												¿Estás seguro que deseas rechazar el préstamo <strong>#<%=p.getIdPrestamo()%></strong>?
											</div>
											<div class="modal-footer">
												<input type="hidden" name="idPrestamo"
													value="<%=p.getIdPrestamo()%>"> <input
													type="hidden" name="accion" value="rechazar"> <input
													type="hidden" name="fechaDesde"
													value="<%=request.getAttribute("fechaDesdeSeleccionada")%>">
												<input type="hidden" name="fechaHasta"
													value="<%=request.getAttribute("fechaHastaSeleccionada")%>">
												<input type="hidden" name="estado" value="<%=estadoSel%>">
												<input type="hidden" name="cliente"
													value="<%=request.getAttribute("cliente") != null ? request.getAttribute("cliente") : ""%>">
												<input type="hidden" name="cuotas"
													value="<%=request.getAttribute("cuotasSeleccionadas") != null ? request.getAttribute("cuotasSeleccionadas") : ""%>">

												<button type="submit" class="btn btn-danger">Sí,
													rechazar</button>
												<button type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">Cancelar</button>
											</div>
										</form>
									</div>
								</div>
							</div> <%
 } else {
 %> <span class="text-muted">—</span> <%
 }
 %>
						</td>
					</tr>
					<%
					}
					}
					%>
				</tbody>
			</table>
		</div>
	</main>

	<%
	String mensajeExito = (String) request.getAttribute("mensajeExito");
	String mensajeError = (String) request.getAttribute("mensajeError");
	%>

	<div class="position-fixed top-0 end-0 p-4" style="z-index: 1055;">
		<div id="toastNotificacion"
			class="toast align-items-center text-bg-<%=mensajeExito != null ? "success" : "danger"%> border-0 shadow-lg"
			role="alert" aria-live="assertive" aria-atomic="true"
			<%=(mensajeExito != null || mensajeError != null) ? "" : "style='display:none'"%>>
			<div class="d-flex">
				<div class="toast-body fs-6 fw-semibold">
					<%=mensajeExito != null ? mensajeExito : mensajeError != null ? mensajeError : ""%>
				</div>
				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast" aria-label="Cerrar"></button>
			</div>
		</div>
	</div>

	<jsp:include page="Footer.html" />

	<script>
		$(document)
				.ready(
						function() {
							$('#prestamosTable')
									.DataTable(
											{
												"paging" : true,
												"pageLength" : 10,
												"lengthChange" : false,
												"searching" : false,
												"ordering" : true,
												"info" : true,
												"autoWidth" : false,
												"scrollX" : true,
												"language" : {
													"url" : "https://cdn.datatables.net/plug-ins/1.13.1/i18n/es-ES.json"
												}
											});
						});
	</script>
	<script>
		window.addEventListener("DOMContentLoaded", function() {
			const toastEl = document.getElementById("toastNotificacion");
			if (toastEl) {
				const toast = new bootstrap.Toast(toastEl);
				toast.show();
			}
		});
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>

</body>
</html>
