<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="entidad.Usuario, entidad.Cuota, entidad.Cuenta, java.util.List, java.text.NumberFormat, java.util.Locale" %>    
    
    <%@ include file="fragmentos/VerificarSesion.jspf"%>
<%
    Cuota cuotaAPagar = (Cuota) request.getAttribute("cuotaAPagar");
    List<Cuenta> listaCuentas = (List<Cuenta>) request.getAttribute("listaCuentas");
    
    if (cuotaAPagar == null || listaCuentas == null) {
        response.sendRedirect("MisPrestamosServlet");
        return;
    }
    
    NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("es", "AR"));
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pago de cuota</title>
<!-- Boostrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet"
 integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
 <!-- Bootstrap Iconos -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
	rel="stylesheet">
<!-- Favicon  -->
<link rel="icon" href="assets/bank.png" type="image/png" />
 
 <style>
 body {
	background-color: #f8f9fa;
	display: flex;
	flex-direction: column;
	min-height: 100vh;
	background-image: url('assets/client-bg.jpg');
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
}
.container {
	flex: 1;
}
</style>
</head>
<body>
<jsp:include page="Nav.jsp"/> 

<div class="container mt-4">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card shadow-sm border rounded p-4">
       
       <!-- Titulo -->
       <h3 class="fw-bold text-primary"><i class="bi bi-cash-coin"></i> Pago de cuota</h3>       
       <p class="text-muted mb-4">Revise los datos y seleccione una cuenta para realizar el pago.</p>
       
		<table class="table table-bordered text-center">
          <thead class="table-primary">
            <tr>
              <th scope="col">Préstamo N°</th>
              <th scope="col">Nro. Cuota</th>
              <th scope="col">Valor a Pagar</th>
            </tr>
          </thead>
          <tbody>		    
            <tr>
              <td><%= cuotaAPagar.getIdPrestamo() %></td>
              <td><%= cuotaAPagar.getNumCuota() %></td>
              <td class="text-success fw-semibold"><%= formatter.format(cuotaAPagar.getMonto()) %></td>
            </tr>
          </tbody>
        </table>
		
		<br>
		
		<form action="ProcesarPagoServlet" method="post">
            <input type="hidden" name="idCuota" value="<%= cuotaAPagar.getIdPagoDeCuota() %>">
            <input type="hidden" name="idPrestamo" value="<%= cuotaAPagar.getIdPrestamo() %>">

            <div class="mb-3">
                <label for="selectCuenta" class="form-label fw-bold">Pagar desde la cuenta:</label>
                <select class="form-select" id="selectCuenta" name="numCuentaOrigen" required>
                    <option value="" selected disabled>-- Seleccione una cuenta --</option>
                    <%
                        for (Cuenta c : listaCuentas) {
                            if (c.getSaldo() >= cuotaAPagar.getMonto()) {
                    %>
                                <option value="<%= c.getNumDeCuenta() %>">
                                    <%= c.getTipoCuenta().getDescripcion() %> N° <%= c.getNumDeCuenta() %> (Saldo: <%= formatter.format(c.getSaldo()) %>)
                                </option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>
			 
            <div class="d-grid gap-2 col-8 mx-auto mt-4">
                <button type="submit" class="btn btn-success btn-lg">
                     Confirmar y Pagar <i class="bi bi-check2"></i>
                </button>
                <a href="DetallePrestamoServlet?idPrestamo=<%= cuotaAPagar.getIdPrestamo() %>" class="btn btn-secondary">Cancelar</a>
            </div>
		</form>
		
		</div>
      </div>
    </div>
  </div>
 <jsp:include page="Footer.html" />
</body>
</html>