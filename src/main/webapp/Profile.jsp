<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="daoImpl.ClienteImpl" import="entidad.Cliente"%>
<%@ include file="fragmentos/VerificarSesion.jspf"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Perfil de Usuario</title>
<!-- Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Bootstrap Iconos -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
	rel="stylesheet">
<!-- Fuente Inter -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=swap"
	rel="stylesheet">
<!-- Css -->
<link rel="StyleSheet" href="Styles.css" type="text/css" />
<!-- Favicon-->
<link rel="icon" href="assets/bank.png" type="image/png" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">


<style>
html, body {
	height: 100%;
	margin: 0;
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

body {
	background-color: var(--body-color);
	font-family: "Inter", sans-serif;
	color: var(--text-color);
	background-image: url('assets/bg2.jpg');
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
	flex: 1;
}

.container {
	flex: 1;
}

.profile-card {
	margin-top: 50px;
	margin-bottom: 50px; /
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
	overflow: hidden;
}

.profile-card-header {
	background-color: var(--primary-color);
	color: var(--second-color);
	padding: 20px;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	text-align: center;
}

.profile-card-header h2 {
	margin-bottom: 5px;
}

.profile-detail {
	padding: 15px 20px;
	border-bottom: 1px solid #eee;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.profile-detail:last-child {
	border-bottom: none;
}

.profile-detail strong {
	color: var(--text-color);
	font-weight: 600;
	flex-shrink: 0;
	margin-right: 15px;
}

.profile-detail span {
	text-align: right;
	flex-grow: 1;
	color: var(--text-second);
	word-break: break-word;
}

.btn-secondary {
	background-color: var(--btn-color);
	border-color: var(--btn-color);
	color: var(--text-color);
	border-radius: 5px;
	padding: 10px 20px;
	transition: background-color 0.3s ease, transform 0.2s ease;
}

.btn-secondary:hover {
	background-color: var(--primary-alpha-color);
	border-color: var(--primary-alpha-color);
	color: var(--second-color);
	transform: translateY(-2px);
}
</style>
</head>
<body>
	<jsp:include page="Nav.jsp" />

	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-8 col-lg-6">
				<div class="card profile-card">
					<div class="profile-card-header">
						<h2 class="mb-4 text-center">
							Bienvenido, <strong><%=usuarioLogueado.getNombreUsuario()%></strong>
							👨‍💼
						</h2>
					</div>
					<div class="card-body">
						<!-- Cada campo del perfil se muestra en un div con la clase profile-detail -->
						<% ClienteImpl clienteDao = new ClienteImpl(); 
							Cliente clienteLogueado = clienteDao.
									getClientePorID(usuarioLogueado.getIdcliente());
						
						%>
						
						<div class="profile-detail">
							<strong>Usuario: </strong> <%=usuarioLogueado.getNombreUsuario()%> <span></span>
						</div>
						<div class="profile-detail">
							<strong>DNI: </strong> <%=clienteLogueado.getDni()%> <span></span>
						</div>
						<div class="profile-detail">
							<strong>CUIL: </strong> <%=clienteLogueado.getCuil()%> <span></span>
						</div>
						<div class="profile-detail">
							<strong>Nombre Completo:</strong> <%=clienteLogueado.getNombre()%> <%=clienteLogueado.getApellido()%> <span></span>
						</div>
						<div class="profile-detail">
							<strong>Sexo: </strong> <%=clienteLogueado.getSexo()%><span></span>
						</div>
						<div class="profile-detail">
							<strong>Nacionalidad: </strong> <%=clienteLogueado.getNacionalidad()%><span></span>
						</div>
						<div class="profile-detail">
							<strong>Fecha de Nacimiento: </strong> <%=clienteLogueado.getFechaNacimiento()%><span></span>
						</div>
						<div class="profile-detail">
							<strong>Dirección: </strong> <%=clienteLogueado.getDireccion()%><span></span>
						</div>
<!-- 						<div class="profile-detail"> -->
<%-- 							<strong>Localidad: </strong> <%=clienteLogueado.getIdLocalidad()%><span></span> --%>
<!-- 						</div> -->
<!-- 						<div class="profile-detail"> -->
<%-- 							<strong>Provincia: </strong> <%=clienteLogueado.getIdLocalidad().getIdProvincia().getDescripcion()%><span></span> --%>
<!-- 						</div> -->
						<div class="profile-detail">
							<strong>Correo Electrónico: </strong><%=clienteLogueado.getCorreo()%> <span></span>
						</div>
						<div class="profile-detail">
							<strong>Teléfono: </strong> <%=clienteLogueado.getTelefono()%><span></span>
						</div>

						<div class="mt-4 text-center">
							<a href="ModificarContraseña.jsp" class="btn btn-secondary">Cambiar
								Contraseña</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="Footer.html" />

	<!--      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> 
Se deja comentado porque sino genera conflicto con la declaracion que tiene el nav y no funcionan los dropdowns-->
</body>
</html>