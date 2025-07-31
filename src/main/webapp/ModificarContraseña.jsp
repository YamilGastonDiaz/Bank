<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="fragmentos/VerificarSesion.jspf"%>
<%@ page import="entidad.Usuario"%>
<%@ page contentType="text/html; charset=UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cambiar Constraseña - Novabank</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="Style.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

</head>
<body>

	<jsp:include page="Nav.jsp" />

	<div
		class="bg-gradient-custom min-vh-100 d-flex justify-content-center align-items-center py-5">
		<div class="container">
			<div class="row align-items-center">

				<!-- Imagen a la izquierda -->
				<div class="col-md-6 text-center mb-4 mb-md-0">
					<img src="assets/Pass1.png" alt="Password Novabank"
						class="img-left img-fluid">
				</div>

				<!-- Formulario a la derecha -->
				<div class="col-md-6">
					<div class="form-container">

						<div class="text-center mb-4">
							<h2 class="fw-bold text-primary">¿Querés cambiar tu
								contraseña?</h2>
							<p class="text-muted">Es importante mantener tus datos
								seguros</p>
						</div>

						<form class="row g-3" action="ModificarPasswordServlet"
							method="post">
							<input type="hidden" name="accion" value="cambiarPasswordForm">

							<div class="col-md-6">
								<label for="actual" class="form-label">Ingresa tu
									contraseña actual</label>
								<div class="input-group">
									<input id="actual" name="actual"
										class="form-control rounded-start-pill bg-light border-2"
										type="password" placeholder="Mínimo 8 caracteres" /> <span
										class="input-group-text rounded-end-pill toggle-password"
										data-target="actual" style="cursor: pointer;"><i
										class="fa fa-eye"></i></span>
								</div>
							</div>

							<div class="col-md-6">
								<label for="nueva" class="form-label">Nueva Contraseña</label>
								<div class="input-group">
									<input id="nueva" name="nueva"
										class="form-control rounded-start-pill bg-light border-2"
										type="password" placeholder="Mínimo 8 caracteres" /> <span
										class="input-group-text rounded-end-pill toggle-password"
										data-target="nueva" style="cursor: pointer;"><i
										class="fa fa-eye"></i></span>
								</div>
							</div>

							<div class="col-md-6">
								<label for="confirmar" class="form-label">Confirmar
									Contraseña</label>
								<div class="input-group">
									<input id="confirmar" name="confirmar"
										class="form-control rounded-start-pill bg-light border-2"
										type="password" placeholder="Nueva Contraseña" /> <span
										class="input-group-text rounded-end-pill toggle-password"
										data-target="confirmar" style="cursor: pointer;"><i
										class="fa fa-eye"></i></span>
								</div>
							</div>

							<!-- Botones -->
							<div class="col-12 d-grid gap-2 mt-3">
								<button type="submit"
									class="btn btn-primary btn-lg rounded-pill">Guardar</button>
								<button type="reset"
									class="btn btn-outline-secondary btn-lg rounded-pill">Cancelar</button>
							</div>

							<%
							String mensajeError = (String) request.getAttribute("mensajeError");
							String mensajeExito = (String) request.getAttribute("mensajeExito");
							if (mensajeError != null) {
							%>
							<div class="alert alert-danger mt-3"><%=mensajeError%></div>
							<%
							}
							if (mensajeExito != null) {
							%>
							<div class="alert alert-success mt-3"><%=mensajeExito%></div>
							<%
							}
							%>
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="Footer.html" />


<script>
  document.querySelectorAll('.toggle-password').forEach(function (el) {
    el.addEventListener('click', function () {
      const targetId = el.getAttribute('data-target');
      const input = document.getElementById(targetId);
      const icon = el.querySelector('i');

      if (input.type === "password") {
        input.type = "text";
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
      } else {
        input.type = "password";
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
      }
    });
  });
</script>



</body>
</html>
