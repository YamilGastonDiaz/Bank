<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="entidad.Usuario, entidad.Movimiento"%>
<%@ page
	import="java.util.List, entidad.Cuenta, java.text.NumberFormat, java.util.Locale"%>
<%@ include file="fragmentos/VerificarSesion.jspf"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="Styles.css">
<style>
body {
	display: flex;
	flex-direction: column;
}

main {
	flex: 1;
}

.card-cuenta {
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	border-radius: 15px;
	padding: 1rem;
	height: 100%;
}

.btn-atajo {
	width: 160px;
	height: 160px;
	font-size: 1.2rem;
	background-color: #0C6EFE;
	color: white;
	border-radius: 20px;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	text-align: center;
	transition: transform 0.2s;
	border: none;
}

.btn-atajo:hover {
	transform: scale(1.05);
}

/* vista ADMIN */
.admin-dashboard {
	position: relative;
	display: flex;
	align-items: center;
	justify-content: flex-start;
	background-color: transparent;
	border-radius: 15px;
	padding: 0;
	min-height: 600px;
}

.admin-image {
	position: relative;
	width: 100%;
	display: flex;
	justify-content: center;
}

.admin-image img {
	width: 100%;
	object-fit: cover;
	border-radius: 15px;
	max-height: 700px;
}

.admin-buttons {
	position: absolute;
	top: 50%;
	left: 5%;
	transform: translateY(-50%);
	display: flex;
	flex-direction: column;
	gap: 20px;
	z-index: 3;
}

/* vista CLIENTE */
.cliente-bg {
	background-image: url('assets/client-bg.jpg');
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
	border-radius: 15px;
	padding: 30px;
}
</style>
</head>
<body>

	<jsp:include page="Nav.jsp" />

	<main class="container mt-4">

		<%
		String mensajeExito = (String) request.getAttribute("mensajeExito");
		if (mensajeExito != null) {
		%>
		<div class="alert alert-success text-center" role="alert">
			<%=mensajeExito%>
		</div>
		<%
		}
		%>
		<%
		if (tipoUsuario  == 1) {
		%>
		<!-- Vista ADMIN -->
		<h2 class="mb-4 text-center">
			Bienvenido, <strong><%=usuarioLogueado.getNombreUsuario()%></strong>
			👨‍💼
		</h2>

		<div class="admin-dashboard">
			<div class="admin-image">
				<img src="assets/admin-bg.jpg" alt="Panel Admin" class="img-fluid">
			</div>

			<div class="admin-buttons">
				<button class="btn-atajo" onclick="location.href='listarClientes'">
					<i class="fas fa-users fa-2x mb-2"></i> Usuarios
				</button>
				<button class="btn-atajo"
					onclick="location.href='ListarCuentasServlet'">
					<i class="fas fa-university fa-2x mb-2"></i> Cuentas
				</button>
				<button class="btn-atajo"
					onclick="location.href='ListarPrestamoServlet'">
					<i class="fas fa-hand-holding-usd fa-2x mb-2"></i> Préstamos
				</button>
				<button class="btn-atajo" onclick="location.href='ReportesServlet'">
					<i class="fas fa-chart-line fa-2x mb-2"></i> Informes
				</button>
			</div>
		</div>

		<%
		} else if (tipoUsuario == 2) {
		%>
		<!-- Vista CLIENTE -->
		<div class="cliente-dashboard position-relative rounded">
			<div class="cliente-image position-relative">
				<img src="assets/client-bg.jpg" alt="Fondo Cliente"
					class="img-fluid w-100 h-100 object-fit-cover rounded">
			</div>

			<div
				class="cliente-contenido position-absolute top-0 start-0 w-100 h-100 px-3 py-4">
				<h2 class="mb-5 text-center">
					Hola, <strong><%=usuarioLogueado.getNombreUsuario()%></strong> 👋
				</h2>

				<!--				Estado de cuentas -->
				<div class="text-center mb-4">
				  <div class="d-flex justify-content-between align-items-center px-3">
				    <h4 class="mb-0">CUENTAS:</h4>
				    <button id="btnToggleSaldo" class="btn btn-outline-secondary btn-sm">
				      <i id="iconoSaldo" class="fas fa-eye-slash"></i> <span id="textoSaldo">Ocultar saldo</span>
				    </button>
				  </div>
				
				  <div class="row justify-content-center mt-4">
				    <%
				    List<Cuenta> listaCuentas = (List<Cuenta>) session.getAttribute("listaCuentas");
				    NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("es", "AR"));
				
				    if (listaCuentas != null && !listaCuentas.isEmpty()) {
				      for (Cuenta c : listaCuentas) {
				    %>
				    <div class="col-md-4 mb-3">
				      <div class="card card-cuenta">
				        <div class="card-body">
				          <h5 class="card-title fw-bold text-primary"><%=c.getTipoCuenta().getDescripcion()%></h5>
				          <p class="card-text">Nro: <%=c.getNumDeCuenta()%></p>
				          <p class="card-text text-muted small">CBU: <%=c.getCbu()%></p>
				          <h5 class="card-text fw-bold saldo-cuenta" data-saldo="<%=formatter.format(c.getSaldo())%>">
				            <%=formatter.format(c.getSaldo())%>
				          </h5>
				          <div class="d-flex justify-content-center align-items-center gap-2 mt-3">
				            <button class="btn btn-light btn-sm" title="Copiar CBU">
				              <i class="fas fa-copy me-1"></i> Copiar CBU
				            </button>
				            <a href="MovimientoServlet?cbu=<%=c.getCbu()%>" class="btn btn-outline-primary btn-sm" title="Ver movimientos">
				              <i class="fas fa-search me-1"></i> Ver movimientos
				            </a>
				          </div>
				        </div>
				      </div>
				    </div>
				    <%
				      }
				    } else {
				    %>
				    <div class="col">
				      <div class="alert alert-info">No tienes cuentas activas para mostrar en este momento.</div>
				    </div>
				    <%
				    }
				    %>
				  </div>
				</div>


				<!-- Atajos Cliente -->
				<div class="text-center">
					<h4 class="mt-5 mb-3 ms-5">Accesos Rápidos</h4>
					<div class="accesos-rapidos d-flex justify-content-center"
						style="margin-left: 180px;">
						<button class="btn-atajo"
							onclick="location.href='Transferencias.jsp'">
							<i class="fas fa-exchange-alt fa-2x mb-2"></i> Transferencias
						</button>

						<button class="btn-atajo"
							onclick="location.href='MisPrestamosServlet'">
							<i class="fas fa-hand-holding-usd fa-2x mb-2"></i> Préstamos
						</button>
					</div>
				</div>
			</div>
		</div>
		<%
		} else {
		%>
		<p class="text-center text-danger">Tipo de usuario desconocido.
			Contacte al administrador.</p>
		<%
		}
		%>

	</main>

	<jsp:include page="Footer.html" />
	<script>
	  const btnToggleSaldo = document.getElementById("btnToggleSaldo");
	  const icono = document.getElementById("iconoSaldo");
	  const texto = document.getElementById("textoSaldo");
	  let saldosVisibles = true;
	
	  btnToggleSaldo.addEventListener("click", () => {
	    const saldos = document.querySelectorAll(".saldo-cuenta");
	
	    saldos.forEach((saldo) => {
	      if (saldosVisibles) {
	        saldo.textContent = "****";
	      } else {
	        saldo.textContent = saldo.getAttribute("data-saldo");
	      }
	    });
	
	    icono.classList.toggle("fa-eye-slash");
	    icono.classList.toggle("fa-eye");
	    texto.textContent = saldosVisibles ? "Mostrar saldo" : "Ocultar saldo";
	
	    saldosVisibles = !saldosVisibles;
	  });
	</script>


</body>
</html>
