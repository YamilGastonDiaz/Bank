<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="entidad.Usuario"%>
<%
Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogin");

if (usuarioLogueado != null) {
	response.sendRedirect("Home.jsp");
	return;
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Iniciar Sesión</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
body {
	background-color: #f8f9fa;
	display: flex;
	flex-direction: column;
	min-height: 100vh;
	background-image: url('assets/bg2.jpg');
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
}

.nav-wrapper {
	width: 100%;
}

.content-wrapper {
	flex-grow: 1;
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 20px;
}

.containerInicio {
	background-color: #ffffff;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	margin-top: 0;
	max-width: 500px;
	width: 100%;
}

.login-container h2 {
	margin-bottom: 25px;
	text-align: center;
	color: #343a40;
}

.form-label {
	font-weight: bold;
}

.btn-primary {
	width: 100%;
	margin-top: 15px;
}

.text-center a {
	display: block;
	margin-top: 15px;
	color: #007bff;
	text-decoration: none;
}

.text-center a:hover {
	text-decoration: underline;
}
#btnMostrarPassword i {
  font-size: 1.2rem;
}
</style>
</head>
<body>
	<div class="nav-wrapper">
		<jsp:include page="Nav.jsp" />
	</div>

	<div class="content-wrapper">
		<div class="containerInicio">
			<h2>Iniciar Sesión</h2>
			<form action="LoginUsuario" method="POST" id="formLogin">
				<div class="mb-3">
					<label for="username" class="form-label">Usuario</label> <input
						type="text" class="form-control" id="username" name="username"
						placeholder="Ingresa tu usuario" required>
				</div>
				<div class="mb-3">
  <label for="password" class="form-label">Contraseña</label>
  <div class="input-group">
    <input type="password" class="form-control" id="password" name="password"
           placeholder="Ingresa tu contraseña" required>
    <button class="btn btn-outline-secondary" type="button" id="btnMostrarPassword" onclick="mostrarPassword()">
      <i class="fa fa-eye-slash" id="iconoPassword"></i>
    </button>
  </div>
</div>

				<button type="submit" class="btn btn-primary" id="btnLogin"
					name="btnLogin">Ingresar</button>
				<div class="text-center"></div>
			</form>
		</div>
	</div>

	<!-- Modal de error de login -->
	<div class="modal fade" id="loginErrorModal" tabindex="-1"
		aria-labelledby="loginErrorModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header bg-danger text-white">
					<h5 class="modal-title" id="loginErrorModalLabel">Error de
						inicio de sesión</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Cerrar"></button>
				</div>
				<div class="modal-body">${errorLogin}</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal" onclick="resetLoginForm()">Intentar
						de nuevo</button>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="Footer.html" />

<script>
  document.addEventListener("DOMContentLoaded", function () {
    var tieneError = <%= request.getAttribute("errorLogin") != null %>;
    if (tieneError) {
      var modal = new bootstrap.Modal(document.getElementById('loginErrorModal'));
      modal.show();
    }
  });

  function resetLoginForm() {
    const form = document.getElementById('formLogin');
    if (form) {
      form.reset();
    }
  }
  
  function mostrarPassword() {
	  const passwordInput = document.getElementById("password");
	  const icon = document.getElementById("iconoPassword");
	  const esPassword = passwordInput.type === "password";
	  passwordInput.type = esPassword ? "text" : "password";
	  icon.className = esPassword ? "fa fa-eye" : "fa fa-eye-slash";
	}
</script>


</body>
</html>
