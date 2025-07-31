<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="entidad.Cuenta"%>
<%@ page import="entidad.TipoDeCuenta"%>
<%@ include file="fragmentos/VerificarSesion.jspf"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Administración de Cuentas</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

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
}

main.container {
	background-color: #ffffff;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	margin-top: 30px;
	margin-bottom: 30px;
	flex-grow: 1;
}

h2 {
	color: #007bff;
	margin-bottom: 20px;
}

.btn-action {
	margin-right: 5px;
}

.table-responsive {
	margin-top: 20px;
}

.filter-section {
	background-color: #e9ecef;
	padding: 15px;
	border-radius: 5px;
	margin-bottom: 20px;
}

footer {
	background-color: #f8f9fa;
	padding: 15px 0;
	text-align: center;
}
</style>
</head>
<body>

	<jsp:include page="Nav.jsp" />

	<%
	List<Cuenta> listaCuentas = (List<Cuenta>) request.getAttribute("listaCuentas");

	String filtroTipoCuenta = (String) request.getAttribute("filtroTipoCuenta");
	if (filtroTipoCuenta == null)
		filtroTipoCuenta = "";

	String filtroEstado = (String) request.getAttribute("filtroEstado");
	if (filtroEstado == null)
		filtroEstado = "";

	String filtroDni = (String) request.getAttribute("filtroDni");
	if (filtroDni == null)
		filtroDni = "";
	%>

	<main class="container">
		<div class="d-flex justify-content-between align-items-center mb-4">
			<h2 class="fw-bold">
				<i class="bi bi-person-lines-fill"></i> Administración de Cuentas
			</h2>
			<form action="InsertCuentasServlet" method="get">
				<button type="submit" class="btn btn-primary btn-lg">
					<i class="fas fa-plus-circle"></i> Crear Nueva Cuenta
				</button>
			</form>
		</div>

		<div class="filter-section">
			<form id="formFiltros" action="ListarCuentasServlet" method="get">
				<div class="row align-items-end mb-3 g-3">
					<div class="col-md-4">
						<label for="filtroTipoCuenta" class="form-label">Tipo de
							Cuenta:</label> <select class="form-select" id="filtroTipoCuenta"
							name="filtroTipoCuenta">
							<option value=""
								<%=filtroTipoCuenta.isEmpty() ? "selected" : ""%>>Todos</option>
							<option value="Caja de Ahorro"
								<%="Caja de Ahorro".equals(filtroTipoCuenta) ? "selected" : ""%>>Caja
								de Ahorro</option>
							<option value="Cuenta Corriente"
								<%="Cuenta Corriente".equals(filtroTipoCuenta) ? "selected" : ""%>>Cuenta
								Corriente</option>
							<option value="Cuenta Sueldo"
								<%="Cuenta Sueldo".equals(filtroTipoCuenta) ? "selected" : ""%>>Cuenta
								Sueldo</option>
						</select>
					</div>
					<div class="col-md-4">
						<label for="filtroEstado" class="form-label">Estado:</label> <select
							class="form-select" id="filtroEstado" name="filtroEstado">
							<option value="">Todos</option>
							<option value="ACTIVA"
								<%="ACTIVA".equals(filtroEstado) ? "selected" : ""%>>Activa</option>
							<option value="INACTIVA"
								<%="INACTIVA".equals(filtroEstado) ? "selected" : ""%>>Inactiva</option>
						</select>
					</div>
					<div class="col-md-4 d-flex">
						<button type="submit" class="btn btn-info" name="btnFiltrar">
							<i class="fas fa-filter"></i> Aplicar Filtros
						</button>
						<button type="submit" class="btn btn-secondary ms-2"
							name="btnLimpiarFiltros">
							<i class="fas fa-times"></i> Limpiar Filtros
						</button>
					</div>
				</div>
			</form>
		</div>

		<%
		int registrosPorPagina = 10;
		int pagina = 1;

		if (request.getParameter("pagina") != null) {
			try {
				pagina = Integer.parseInt(request.getParameter("pagina"));
			} catch (NumberFormatException e) {
				pagina = 1;
			}
		}

		int totalRegistros = listaCuentas != null ? listaCuentas.size() : 0;
		int totalPaginas = (int) Math.ceil((double) totalRegistros / registrosPorPagina);
		int inicio = (pagina - 1) * registrosPorPagina;
		int fin = Math.min(inicio + registrosPorPagina, totalRegistros);

		%>

		<div class="table-responsive">
			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<th>Fecha Alta</th>
						<th>Cliente</th>
						<th>DNI</th>
						<th>Tipo de Cuenta</th>
						<th>N° de Cuenta</th>
						<th>CBU</th>
						<th>Saldo</th>
						<th>Estado</th>
						<th>Editar</th>
						<th>Eliminar</th>
					</tr>
				</thead>
				<tbody>
					<%
					if (listaCuentas != null && !listaCuentas.isEmpty()) {
						for (int i = inicio; i < fin; i++) {
							Cuenta cuenta = listaCuentas.get(i);
					%>
					<tr>
						<td><%=cuenta.getFechaCreacion().getDayOfMonth()%>/<%=cuenta.getFechaCreacion().getMonthValue()%>/<%=cuenta.getFechaCreacion().getYear()%></td>
						<td><%=cuenta.getCliente().getNombre()%> <%=cuenta.getCliente().getApellido()%></td>
						<td><%=cuenta.getCliente().getDni()%></td>
						<td><%=cuenta.getTipoCuenta().getDescripcion()%></td>
						<td><%=cuenta.getNumDeCuenta()%></td>
						<td><%=cuenta.getCbu()%></td>
						<td>$<%=String.format("%.2f", cuenta.getSaldo())%></td>
						<td>
						<%
						if (cuenta.Estado()) {
						%> <span class="badge bg-success">ACTIVA</span> <%
						 } else {
						 %> <span class="badge bg-danger">INACTIVA</span> <%
						 }
						 %>
						</td>
						
						<% if (cuenta.Estado()) { %>
						    <td>
						        <a class="btn btn-outline-primary btn-sm btn-action"
						           href="ModificarCuentaServlet?nroCuenta=<%=cuenta.getNumDeCuenta()%>">
						            <i class="bi bi-pen"></i>
						        </a>
						    </td>
						    <td>
						        <form action="EliminarCuentaServlet" method="post"
						              onsubmit="return confirm('¿Estás seguro que deseas dar de baja esta cuenta?');">
						            <input type="hidden" name="numCuenta"
						                   value="<%=cuenta.getNumDeCuenta()%>" />
						            <button type="submit"
						                    class="btn btn-outline-danger btn-sm btn-action" <%= (cuenta.getSaldo() > 0) ? "disabled" : "" %>>
						                <i class="bi bi-trash"></i> Eliminar
						            </button>
						        </form>
						    </td>
						<% } else { %>
						    <td colspan="2" class="text-center text-muted">Cuenta dada de baja</td>
						<% } %>
						
					</tr>
					<%
					}
					} else {
					%>
					<tr>
						<td colspan="10" class="text-center">No hay cuentas para
							mostrar.</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>

		<div
			class="d-flex justify-content-between align-items-center flex-wrap mb-3">
			<%
			if (totalPaginas > 1) {
			%>
			<nav aria-label="Paginación">
				<ul class="pagination justify-content-center">
					<li class="page-item <%=(pagina == 1) ? "disabled" : ""%>"><a
						class="page-link"
						href="ListarCuentasServlet?pagina=<%=(pagina - 1)%>&filtroTipoCuenta=<%=filtroTipoCuenta%>&filtroEstado=<%=filtroEstado%>">Anterior</a>
					</li>
					<%
					for (int i = 1; i <= totalPaginas; i++) {
					%>
					<li class="page-item <%=(i == pagina) ? "active" : ""%>"><a
						class="page-link"
						href="ListarCuentasServlet?pagina=<%=i%>&filtroTipoCuenta=<%=filtroTipoCuenta%>&filtroEstado=<%=filtroEstado%>"><%=i%></a>
					</li>
					<%
					}
					%>
					<li
						class="page-item <%=(pagina == totalPaginas) ? "disabled" : ""%>">
						<a class="page-link"
						href="ListarCuentasServlet?pagina=<%=(pagina + 1)%>&filtroTipoCuenta=<%=filtroTipoCuenta%>&filtroEstado=<%=filtroEstado%>">Siguiente</a>
					</li>
				</ul>
			</nav>
			<%
			}
			%>

			<div class="input-group ms-auto" style="max-width: 250px;">
				<span class="input-group-text">Buscar</span> <input type="text"
					class="form-control" id="filtroDni" name="filtroDni"
					placeholder="DNI" form="formFiltros" value="<%=filtroDni%>">
				<button type="submit" class="btn btn-outline-secondary"
					form="formFiltros" name="btnBuscar">
					<i class="bi bi-search"></i>
				</button>
			</div>
		</div>
	</main>

	<jsp:include page="Footer.html" />

</body>
</html>
