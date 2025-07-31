<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="entidad.Usuario"%>
<%
Usuario usuarioLogueado = (Usuario) session.getAttribute("usuario");
byte tipoUsuario = 0;
if (usuarioLogueado != null) {
	tipoUsuario = usuarioLogueado.getTipoUser().getIdTipoUser();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700&display=swap" rel="stylesheet">
<!-- Estilos -->
<link rel="stylesheet" href="Styles.css" type="text/css" />
<!-- Favicon -->
<link rel="icon" href="assets/bank.png" type="image/png" />

<style>
.navbar {
	min-height: 72px;
	padding-top: 0.5rem;
	padding-bottom: 0.5rem;
}
</style>
</head>

<body>
	<header>
		<nav class="navbar navbar-expand-lg bg-white shadow-sm position-relative">
			<div class="container-fluid">
				<!-- Botón toggler para mobile -->
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
					data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
					aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<!-- Logo centrado en mobile -->
				<a class="navbar-brand mx-auto d-lg-none fw-bold text-primary"
					href="Home.jsp">
					<i class="bi bi-bank me-2"></i> Novabank
				</a>

				<!-- Logo centrado en desktop -->
				<a class="navbar-brand position-absolute top-50 start-50 translate-middle text-primary fw-bold d-none d-lg-block fs-2"
					href="Home.jsp"
					style="font-size: 1.8rem;">
					<i class="bi bi-bank me-2 fs-2"></i> Novabank
				</a>

				<!-- Menús (visible solo si hay usuario logueado) -->
				<div class="collapse navbar-collapse" id="navbarNavDropdown">
					<ul class="navbar-nav me-auto">
						<%
						if (usuarioLogueado != null) {
							if (tipoUsuario == 2) {
						%>
						<!-- CLIENTE -->
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle fs-4" href="#" role="button"
								data-bs-toggle="dropdown">
								<i class="bi bi-person-fill me-2 fs-4"></i> Menu
							</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item d-flex align-items-center fs-5"
									href="Home.jsp"><i class="bi bi-house-door-fill me-2"></i> Home</a></li>
								<li><a class="dropdown-item fs-5 text-dark" href="MovimientoServlet"><i class="bi bi-list-columns-reverse me-2"></i> Movimientos</a></li>
								
								<li><a class="dropdown-item fs-5 text-dark"
									href="Transferencias.jsp"><i class="bi bi-arrow-left-right me-2"></i> Transferencias</a></li>
								<li><a class="dropdown-item ps-4 fs-5 d-flex align-items-center"
									href="TransferenciaCbuServlet"><i class="bi bi-arrow-up-right-square me-2"></i> Nueva a CBU</a></li>
								<li><a class="dropdown-item ps-4 d-flex align-items-center fs-5"
									href="TransferenciaPropiaServlet"><i class="bi bi-repeat me-2"></i> Entre Cuentas Propias</a></li>
								<li><a class="dropdown-item fs-5 text-dark"
									href="MisPrestamosServlet"><i class="bi bi-cash-stack me-2"></i> Préstamos</a></li>
								<li><a class="dropdown-item ps-4 d-flex align-items-center fs-5"
									href="GetionPrestamoServelet"><i class="bi bi-pencil-square me-2"></i> Solicitar</a></li>
								<li><a class="dropdown-item ps-4 d-flex align-items-center fs-5"
									href="MisPrestamosServlet"><i class="bi bi-currency-dollar me-2"></i> Pagar Cuotas</a></li>
							</ul>
						</li>
						<% } else if (tipoUsuario == 1) { %>
						<!-- ADMIN -->
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle fs-4" href="#" role="button"
								data-bs-toggle="dropdown">
								<i class="bi bi-person-fill me-2 fs-4"></i> Menu
							</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item d-flex align-items-center fs-5"
									href="Home.jsp"><i class="bi bi-house-door-fill me-2"></i> Home</a></li>
								<li><a class="dropdown-item fs-5 d-flex align-items-center"
									href="listarClientes"><i class="bi bi-people-fill me-2"></i> Usuarios</a></li>
								<li><a class="dropdown-item ps-5 fs-5 d-flex align-items-center"
									href="InsertarUserClienteServlet"><i class="bi bi-person-plus-fill me-2"></i> Nuevo</a></li>
								<li><a class="dropdown-item fs-5 d-flex align-items-center"
									href="ListarCuentasServlet"><i class="bi bi-wallet2 me-2"></i> Cuentas</a></li>
								<li><a class="dropdown-item ps-5 fs-5 d-flex align-items-center"
									href="InsertCuentasServlet"><i class="bi bi-plus-square me-2"></i> Nueva</a></li>
								<li><a class="dropdown-item fs-5 d-flex align-items-center"
									href="ListarPrestamoServlet"><i class="bi bi-check2-square me-2"></i> Aprobación Prestamos</a></li>
								<li><a class="dropdown-item fs-5 d-flex align-items-center"
									href="ReportesServlet"><i class="bi bi-clipboard-data me-2"></i> Informes</a></li>
							</ul>
						</li>
						<% } } %>
					</ul>

					<!-- Usuario (si está logueado) -->
					<ul class="navbar-nav ms-auto">
						<% if (usuarioLogueado != null) { %>
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle fw-semibold text-dark fs-4"
								href="#" id="userDropdown" role="button" data-bs-toggle="dropdown"
								aria-expanded="false">
								<i class="bi bi-person-circle me-1 fs-3"></i>
								<%=usuarioLogueado.getNombreUsuario()%>
							</a>
							<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
								<% if (tipoUsuario == 1) { %>
								<li><a class="dropdown-item fs-5" href="ModificarContraseña.jsp">
									<i class="bi bi-shield-lock-fill me-2"></i> Cambiar Contraseña</a></li>
								<% } else if (tipoUsuario == 2) { %>
								<li><a class="dropdown-item fs-5" href="Profile.jsp">
									<i class="bi bi-person-lines-fill me-2"></i> Ver Perfil</a></li>
								<% } %>
								<li><hr class="dropdown-divider"></li>
								<li>
									<form action="LoginUsuario" method="post" style="margin: 0;">
										<button type="submit" name="btnLogout" class="dropdown-item text-danger fs-5">
											<i class="bi bi-power me-2"></i> Cerrar sesión
										</button>
									</form>
								</li>
							</ul>
						</li>
						<% } %>
					</ul>
				</div>
			</div>
		</nav>
	</header>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
