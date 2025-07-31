<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, entidad.Cuota, java.text.NumberFormat, java.util.Locale" %>
<%@ include file="fragmentos/VerificarSesion.jspf" %>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Cuotas Pendientes</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/2.3.2/css/dataTables.bootstrap5.min.css">

<style>
body {
  background-color: var(--body-color);
  font-family: "Inter", sans-serif;
  color: var(--text-color);
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  background-image: url('assets/bg1.jpg');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
}
.main-content {
  padding-top: 30px;
  padding-bottom: 50px;
  flex: 1;
}
.section-header {
  background-color: var(--primary-color);
  color: var(--second-color);
  padding: 15px;
  border-radius: 8px;
  margin-bottom: 30px;
  text-align: center;
}
.table-container {
  background-color: var(--second-color);
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
  padding: 20px;
}
.table th {
  background-color: var(--primary-alpha-color);
  color: var(--second-color);
  text-align: center;
}
.table td {
  text-align: center;
  color: var(--text-color);
}
.table-responsive {
  margin-top: 20px;
}
.btn-pay {
  background-color: #28a745;
  color: white;
  border-radius: 5px;
}
.status-paid {
  color: #28a745;
  font-weight: bold;
}
.status-pending {
  color: #ffc107;
  font-weight: bold;
}
</style>
</head>
<body>
<jsp:include page="Nav.jsp" />
<div class="container main-content">
  <div class="section-header">
    <h1>Cuotas Pendientes de Pago</h1>
  </div>
  <div class="table-container">
    <div class="table-responsive">
      <table id="tablaCuotas" class="table table-striped table-hover">
        <thead>
          <tr>
            <th>Nro. Cuota</th>
            <th>Monto</th>
            <th>Préstamo Asociado</th>
            <th>Estado</th>
            <th>Fecha de Pago</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody>
          <%
          List<Cuota> listaCuotas = (List<Cuota>) request.getAttribute("listaCuotas");
          NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("es", "AR"));
          boolean hayCuotas = (listaCuotas != null && !listaCuotas.isEmpty());
          if (hayCuotas) {
            for (Cuota cuota : listaCuotas) {
          %>
          <tr>
            <td><%= cuota.getNumCuota() %></td>
            <td><%= formatter.format(cuota.getMonto()) %></td>
            <td><%= cuota.getIdPrestamo() %></td>
            <td>
              <% if (cuota.isEstado()) { %>
                <span class="status-pending">PENDIENTE</span>
              <% } else { %>
                <span class="status-paid">PAGADO</span>
              <% } %>
            </td>
            <td><%= (cuota.getFechaPago() != null) ? cuota.getFechaPago() : "---" %></td>
            <td>
              <% if (cuota.isEstado()) { %>
                <a href="PrepararPagoCuotaServlet?idCuota=<%= cuota.getIdPagoDeCuota() %>" class="btn btn-sm btn-pay btn-primary">Pagar</a>
              <% } %>
            </td>
          </tr>
          <%
            }
          }
          %>
        </tbody>
      </table>

      <% if (!hayCuotas) { %>
        <div class="alert alert-info text-center mt-3">
          No se encontraron cuotas para este préstamo.
        </div>
      <% } %>

    </div>
  </div>
</div>
<jsp:include page="Footer.html" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/2.3.2/js/dataTables.min.js"></script>
<script src="https://cdn.datatables.net/2.3.2/js/dataTables.bootstrap5.min.js"></script>

<script>
  const hayCuotas = <%= hayCuotas %>;

  $(document).ready(function () {
    if (hayCuotas) {
      $('#tablaCuotas').DataTable({
        language: {
          url: "https://cdn.datatables.net/plug-ins/1.13.1/i18n/es-ES.json"
        },
        paging: true,
        pageLength: 12,
        lengthChange: false,
        searching: false,
        ordering: true,
        order: [[0, 'asc']],
        info: true,
        autoWidth: false,
        scrollX: false
      });
    }
  });
</script>
</body>
</html>
