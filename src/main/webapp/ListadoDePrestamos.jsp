<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, entidad.Prestamo, java.text.NumberFormat, java.util.Locale" %>
<%@ include file="fragmentos/VerificarSesion.jspf" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tus Préstamos</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/2.3.2/css/dataTables.bootstrap5.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
body {
  background-color: #f8f9fa;
  font-family: "Inter", sans-serif;
  color: #212529;
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  background-image: url('assets/bg1.jpg');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
}
.container {
  background-color: #ffffff;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  margin-top: 30px;
  margin-bottom: 30px;
  max-width: 98%;
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
footer {
  margin-top: auto;
  background-color: #f8f9fa;
  text-align: center;
  padding: 1rem 0;
}
</style>
</head>
<body>
<jsp:include page="Nav.jsp" />
<%
String toastExito = (String) session.getAttribute("toastExito");
String toastError = (String) session.getAttribute("toastError");
session.removeAttribute("toastExito");
session.removeAttribute("toastError");
%>

<!-- Notificaciones toast -->
<div class="position-fixed top-0 end-0 p-3" style="z-index: 1100">
  <div id="toastMensaje" class="toast align-items-center text-white <%= (toastExito != null) ? "bg-success" : (toastError != null) ? "bg-danger" : "" %> border-0" role="alert" aria-live="assertive" aria-atomic="true" style="<%= (toastExito != null || toastError != null) ? "display:block;" : "display:none;" %>">
    <div class="d-flex">
      <div class="toast-body">
        <%= (toastExito != null) ? toastExito : toastError %>
      </div>
      <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Cerrar"></button>
    </div>
  </div>
</div>


<div class="container flex-grow-1 d-flex flex-column">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Tus Préstamos</h2>
    <form action="GetionPrestamoServelet" method="get">
      <button type="submit" class="btn btn-primary btn-lg">
        <i class="fas fa-plus-circle"></i> Solicitar Nuevo Préstamo
      </button>
    </form>
  </div>
  
  
  <hr class="my-4">
  <div class="filtrosPrestamos">
    <form action="MisPrestamosServlet" method="get">
      <div class="row g-3 align-items-end">
        <div class="col-md-4">
          <label for="estado" class="form-label">Filtrar por Estado:</label>
          <%
          String estadoSeleccionado = request.getParameter("estado");
          if (estadoSeleccionado == null) estadoSeleccionado = "";
          %>
          <select class="form-select" id="estado" name="estado">
            <option value="" <%=estadoSeleccionado.equals("") ? "selected" : ""%>>Todos los estados</option>
            <option value="Pendiente de aprobación" <%=estadoSeleccionado.equals("Pendiente de aprobación") ? "selected" : ""%>>Pendiente de Aprobación</option>
            <option value="Activo" <%=estadoSeleccionado.equals("Activo") ? "selected" : ""%>>Activo</option>
            <option value="Rechazado" <%=estadoSeleccionado.equals("Rechazado") ? "selected" : ""%>>Rechazado</option>
            <option value="Finalizado" <%=estadoSeleccionado.equals("Finalizado") ? "selected" : ""%>>Finalizado</option>
          </select>
        </div>
        <div class="col-md-auto">
          <button type="submit" class="btn btn-primary" name="btnAplicarFiltro">
            <i class="fas fa-filter"></i> Aplicar Filtro
          </button>
        </div>
        <div class="col-md-auto">
          <button type="button" class="btn btn-secondary" onclick="limpiarFiltros()">
            <i class="fas fa-times"></i> Limpiar Filtro
          </button>
        </div>
      </div>
    </form>
  </div>
  
  
  <div class="table-responsive">
  <table id="tablaPrestamos" class="table table-striped table-hover">
    <thead class="table-primary">
      <tr>
        <th>Fecha Alta</th>
        <th>Importe Solicitado</th>
        <th>Cuota ($)</th>
        <th>Cuotas Totales</th>
        <th>Cuotas Pendientes</th>
        <th>Estado</th>
        <th>Acciones</th>
      </tr>
    </thead>
    <tbody>
      <%
      List<Prestamo> listaPrestamos = (List<Prestamo>) request.getAttribute("listaPrestamos");
      NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("es", "AR"));
      if (listaPrestamos != null && !listaPrestamos.isEmpty()) {
        for (Prestamo p : listaPrestamos) {
          String estadoTexto = "Pendiente";
          String estadoClase = "bg-warning text-dark";
          if (p.isFinalizado()) {
            estadoTexto = "Finalizado";
            estadoClase = "bg-info";
          } else if (p.isAprobado()) {
            estadoTexto = "Activo";
            estadoClase = "bg-success";
          } else if (p.isEstado()) {
            estadoTexto = "Rechazado";
            estadoClase = "bg-danger";
          }

          int cuotasTotales = p.getCuotas();
          int cuotasPagadas = p.getCuotasPagadas();
          int cuotasRestantes = Math.max(0, cuotasTotales - cuotasPagadas);
      %>
      <tr>
        <td><%= p.getFecha() %></td>
        <td><%= formatter.format(p.getImportePedido()) %></td>
        <td><%= formatter.format(p.getImporteMensual()) %></td>
        <td><%= cuotasTotales %></td>
        <td><%= cuotasRestantes %></td>
        <td><span class="badge <%= estadoClase %>"><%= estadoTexto %></span></td>
        <td>
          <% if (p.isAprobado()) { %>
            <a href="DetallePrestamoServlet?idPrestamo=<%= p.getIdPrestamo() %>" class="btn btn-primary btn-sm btn-action">
              <i class="fas fa-list-ol"></i> Ver Cuotas
            </a>
          <% } else { %>
            <button class="btn btn-secondary btn-sm btn-action" disabled>
              <i class="fas fa-list-ol"></i> Ver Cuotas
            </button>
          <% } %>
        </td>
      </tr>
      <%
        }
      }
      %>
    </tbody>
  </table>
</div>

</div>
<jsp:include page="Footer.html" />

<script src="https://cdn.datatables.net/2.3.2/js/dataTables.min.js"></script>
<script src="https://cdn.datatables.net/2.3.2/js/dataTables.bootstrap5.min.js"></script>
<script>
  $(document).ready(function () {
    $('#tablaPrestamos').DataTable({
      language: {
        url: "https://cdn.datatables.net/plug-ins/1.13.1/i18n/es-ES.json"
      },
      paging: true,
      pageLength: 10,
      lengthChange: false,
      searching: false,
      ordering: true,
      order: [[0, 'desc']],
      info: true,
      autoWidth: false,
      scrollX: false
    });
  });
  
  function limpiarFiltros() {
    document.getElementById("estado").value = "";
    document.querySelector("form[action='MisPrestamosServlet']").submit();
  }
  
  document.addEventListener("DOMContentLoaded", function () {
	  const toastEl = document.getElementById("toastMensaje");
	  if (toastEl) {
	    const toast = new bootstrap.Toast(toastEl, {
	      delay: 4000,
	      autohide: true
	    });
	    
	    toastEl.addEventListener('hidden.bs.toast', function () {
	      toastEl.style.display = 'none';
	    });

	    toast.show();
	  }
	});

</script>
</body>
</html>
