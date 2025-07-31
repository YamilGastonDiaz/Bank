<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="fragmentos/VerificarSesion.jspf"%>
<!DOCTYPE html>
<html>
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
<head>
<meta charset="UTF-8">
<title>Transferencias</title>

</head>
<body>
	<jsp:include page="Nav.jsp"/>
	 
	<div class="container mb-4 mt-4">
		<section class="row justify-content-center">

			<article class="col-12 text-center mb-4">
				<h1 class="fw text-primary"><i class="bi bi-arrow-left-right"></i>
					Transferencias
				</h1>
			</article>
			
			<article class="col-12">
				<h3 class="text-center">
					¿Querés hacer una nueva transferencia?
				</h3>
			</article>
			
			<article class="d-flex justify-content-center gap-3 col-12 mx-auto m-2">
			    <a href="TransferenciaCbuServlet" type="button" class="btn btn-primary btn-lg" style="width: 250px; height: 50px;">
			        A un CBU
			    </a>
			    <a href="TransferenciaPropiaServlet" type="button" class="btn btn-primary btn-lg" style="width: 250px; height: 50px;">
			        A una Cuenta Propia
			    </a>
			</article>	
				
		<%
		   String mensaje = request.getParameter("mensaje");
		
		   if ("ok".equals(mensaje)) {
		%>
		<div class="row justify-content-center mt-4">
    	<div class="col-12 col-md-10 col-lg-6">
		    <div class="alert alert-success alert-dismissible fade show" role="alert"><i class="bi bi-check2-circle"></i> Transferencia realizada con éxito.
		    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		    </div>
	    </div>
  		</div>
		<%
		    } if ("error".equals(mensaje)) {
		%>
		<div class="row justify-content-center mt-4">
    	<div class="col-12 col-md-10 col-lg-8">
		    <div class="alert alert-danger alert-dismissible fade show" role="alert"><i class="bi bi-exclamation-circle"></i> No se pudo realizar la transferencia. Verifique los datos e intente nuevamente.
		    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		    </div>
		</div>
  		</div>
		<%
		    } if ("errorCbu".equals(mensaje)) {
		%>
		<div class="row justify-content-center mt-4">
    	<div class="col-12 col-md-10 col-lg-8">
		    <div class="alert alert-danger alert-dismissible fade show" role="alert"><i class="bi bi-exclamation-circle"></i> No se pudo realizar la transferencia. El cbu ingresado no pertenece a una cuenta activa.
		    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		    </div>
		</div>
  		</div>
		<%
		    }
		%>
		<% if ("cbuInvalido".equals(mensaje)) { %>
		<div class="row justify-content-center mt-4">
    	<div class="col-12 col-md-10 col-lg-10">
		    <div class="alert alert-warning alert-dismissible fade show" role="alert"><i class="bi bi-exclamation-circle"></i> El CBU ingresado no se encuentra registrado en el sistema. Verifique los datos e intente nuevamente.
		    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		    </div>
		</div>
  		</div>
		<% } %>
		<% if ("cbuPropio".equals(mensaje)) { %>
		<div class="row justify-content-center mt-4">
    	<div class="col-12 col-md-10 col-lg-8">
		    <div class="alert alert-warning alert-dismissible fade show" role="alert"><i class="bi bi-exclamation-circle"></i> El CBU ingresado pertenece a una de sus propias cuentas. <br> Para transferencias entre cuentas propias, utilice la opción correspondiente.
		    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		    </div>
		</div>
  		</div>
		<% } %>
		<div class="d-grid gap-2 col-6 mx-auto">
		  <a class="btn btn-success btn-lg" type="button" href="MovimientoServlet"><i class="bi bi-arrow-repeat"></i> Ver Movimientos</a>
		</div>
			
		</section>	
	</div>
	<jsp:include page="Footer.html" />
</body>
</html>