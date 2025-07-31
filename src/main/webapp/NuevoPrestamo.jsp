<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="fragmentos/VerificarSesion.jspf"%>
<%@page import="java.util.List"%>
<%@page import="entidad.Cuenta"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nuevo Préstamo</title>
<link rel="icon" href="assets/bank.png" type="image/png" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="Styles.css">
<style>
html, body {
	height: 100%;
}

body {
	display: flex;
	flex-direction: column;
	min-height: 100vh;
	background-image: url('assets/bg1.jpg');
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
}

main {
	flex: 1;
}

.form-container {
	max-width: 600px;
	margin: 0 auto;
}

.simulacion-card {
	background-color: #f8f9fa;
	border: 1px solid #dee2e6;
	border-radius: 10px;
	padding: 20px;
	margin-top: 30px;
	text-align: center;
}
</style>
</head>
<body>

	<jsp:include page="Nav.jsp" />

	<main class="container mt-5">
		<h2 class="mb-4 text-center">Nuevo Préstamo</h2>

		<div class="form-container">
			<div class="card border-primary shadow-sm p-4">
				<form action="GetionPrestamoServelet" method="post" id="formSimulador">

					<div class="mb-3">
						<label for="monto" class="form-label">Monto deseado</label> 
						<input type="number" class="form-control" name="txtMonto" id="txtMonto"
							placeholder="Ingrese solo numeros" step="0.01" min="0.01">
							<div class="invalid-feedback">Ingresá un monto válido mayor a 0</div>
					</div>

					<div class="mb-3">
						<label for="cuotas" class="form-label">Cantidad de cuotas</label>
						<select class="form-select" name="cantidadCuotas" id="cantidadCuotas">
							<option selected disabled value="">Seleccionar</option>
							<option>6</option>
							<option>12</option>
							<option>24</option>
							<option>36</option>
							<option>48</option>
						</select>
						<div class="invalid-feedback">Seleccioná una cantidad de cuotas</div>
					</div>

					<div class="mb-3">
						<label for="cuentaDestino" class="form-label">Cuenta para recibir el préstamo</label> 
						<select class="form-select" name="numCuenta" id="numCuenta">
							<option selected disabled value="">Seleccionar</option>

							<%
							List<Cuenta> cuentas = (List<Cuenta>) request.getAttribute("cuentasTotal");
							if (cuentas != null && !cuentas.isEmpty()) {
								for (Cuenta cuenta : cuentas) {
							%>
							<option value="<%=cuenta.getNumDeCuenta()%>">
								<%=cuenta.getTipoCuenta().getDescripcion()%> -
								<%=cuenta.getNumDeCuenta()%>
							</option>
							<%
							}
							} else {
							%>
							<option disabled value="">No hay cuentas disponibles</option>
							<%
							}
							%>


						</select>
						<div class="invalid-feedback">Seleccioná una cuenta de destino</div>
					</div>

					<div class="d-grid mb-3">
						<button type="submit" class="btn btn-primary" name="btnSimular" id="btnSimular">
							<i class="fas fa-calculator me-1"></i> Simular
						</button>
					</div>

				</form>

				<div class="simulacion-card">
					<h5 class="mb-4">Resultado de la simulación</h5>

					<div class="text-start">
						<p>
							<strong>Tasa de interés:</strong> ${tna}%
						</p>
						<p>
							<strong>Monto total a devolver:</strong> ${montoTotalFormateado}
						</p>
						<p>
							<strong>Cuota mensual estimada:</strong> ${cuotaMensualFormateada}
						</p>
						<p>
							<strong>Primer vencimiento (cuota 1):</strong> ${primerVencimiento}
						</p>
					</div>

					<div class="text-center mt-4">
						<%
						if (request.getAttribute("monto") != null) {
						%>
						<button type="button" class="btn btn-success"
							data-bs-toggle="modal" data-bs-target="#confirmarPrestamoModal">
							<i class="fas fa-check-circle me-1"></i> Pedir préstamo
						</button>
						<%
						}
						%>
					</div>
				</div>
			</div>
		</div>
	</main>


<!-- Modal de confirmacion de prestamo -->
	<div class="modal fade" id="confirmarPrestamoModal" tabindex="-1"
		aria-labelledby="confirmarPrestamoLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<form action="InsertarPrestamoServlet" method="post">
				<div class="modal-content border-success">
					<div class="modal-header">
						<h5 class="modal-title" id="confirmarPrestamoLabel">
							<i class="fas fa-check-circle text-success me-2"></i>Confirmar
							solicitud de préstamo
						</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Cerrar"></button>
					</div>
					<div class="modal-body">
						<p class="mb-2">Por favor revisá la información antes de
							confirmar:</p>
						<ul class="list-group list-group-flush small">
							<li class="list-group-item"><strong>Monto solicitado:</strong> ${montoPedidoFormateado}</li>
							<li class="list-group-item"><strong>Tasa de interés:</strong> ${tna}%</li>
							<li class="list-group-item"><strong>Monto total a devolver:</strong> ${montoTotalFormateado}</li>
							<li class="list-group-item"><strong>Cuota mensual estimada:</strong> ${cuotaMensualFormateada}</li>
							<li class="list-group-item"><strong>Primer vencimiento:</strong> ${primerVencimiento}</li>
						</ul>

						<!-- Campos ocultos para realizar el insert -->
						<input type="hidden" name="numCuenta" value="${param.numCuenta}" />
						<input type="hidden" name="monto" value="${monto}" /> 
						<input type="hidden" name="cuotas" value="${cuotas}" /> 
						<input type="hidden" name="cuotaMensual" value="${cuotaMensual}" />

					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Cancelar</button>
						<button type="submit" class="btn btn-success">Confirmar</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<jsp:include page="Footer.html" />
	
<script>
  const form = document.getElementById('formSimulador');
  const montoInput = document.getElementById('txtMonto');
  const cuotasSelect = document.getElementById('cantidadCuotas');
  const cuentaSelect = document.getElementById('numCuenta');

  // Validación al enviar el formulario
  form.addEventListener('submit', function(e) {
    let hayErrores = false;

    // Validar monto
    const monto = parseFloat(montoInput.value);
    if (isNaN(monto) || monto <= 0) {
      montoInput.classList.add('is-invalid');
      hayErrores = true;
    } else {
      montoInput.classList.remove('is-invalid');
    }

    // Validar cuotas
    if (cuotasSelect.value === "") {
      cuotasSelect.classList.add('is-invalid');
      hayErrores = true;
    } else {
      cuotasSelect.classList.remove('is-invalid');
    }

    // Validar cuenta
    if (cuentaSelect.value === "") {
      cuentaSelect.classList.add('is-invalid');
      hayErrores = true;
    } else {
      cuentaSelect.classList.remove('is-invalid');
    }

    if (hayErrores) {
      e.preventDefault(); // Evita enviar el formulario
    }
  });

  // Quitar mensajes de error si el usuario corrige los campos
  montoInput.addEventListener('input', () => {
    const monto = parseFloat(montoInput.value);
    if (!isNaN(monto) && monto > 0) {
      montoInput.classList.remove('is-invalid');
    }
  });

  cuotasSelect.addEventListener('change', () => {
    if (cuotasSelect.value !== "") {
      cuotasSelect.classList.remove('is-invalid');
    }
  });

  cuentaSelect.addEventListener('change', () => {
    if (cuentaSelect.value !== "") {
      cuentaSelect.classList.remove('is-invalid');
    }
  });
</script>

	
</body>
</html>
