<%@page import="java.util.List" %>
<%@page import="entidad.TipoDeCuenta" %>
<%@ include file="fragmentos/VerificarSesion.jspf"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ABM de Cuentas</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css">
  <style>
    html, body {
      height: 100%;
    }
    body {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
      background-image: url('assets/bg2.jpg');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
    }
    main {
      flex: 1;
    }
    .form-container {
      max-width: 700px;
      margin: 0 auto;
      background-color: #ffffffcc;
      border-radius: 12px;
      padding: 30px;
      box-shadow: 0 0 15px rgba(0,0,0,0.1);
    }
    .readonly {
      background-color: #e9ecef;
    }
    .input-error {
      border: 3px solid #dc3545 !important;
      box-shadow: 0 0 8px rgba(220, 53, 69, 0.6);
    }
    .form-text {
      font-size: 0.875em;
      color: #6c757d;
    }
    .validation-icon {
      color: #dc3545;
      margin-left: 8px;
      display: none;
    }
    .invalid-feedback-icon {
      display: flex;
      align-items: center;
      gap: 5px;
      color: #dc3545;
      font-size: 0.875em;
    }
  </style>
</head>
<body>
<jsp:include page="Nav.jsp" />
  <main class="container py-5">
    <h2 class="text-primary text-center mb-4">Crear Nueva Cuenta</h2>

    <div class="form-container">
      <form method="post" action="InsertCuentasServlet">
        <!-- DNI del cliente -->
        <div class="mb-3">
          <label for="dni" class="form-label">DNI del Cliente</label>
          <input type="text" class="form-control" name="txtDni" placeholder="Ingrese DNI"  value="<%= request.getAttribute("dni") != null ? request.getAttribute("dni") : "" %>" required>
        </div>

        <!-- Tipo de cuenta -->
        <div class="mb-3">
          <label for="tipoCuenta" class="form-label">Tipo de Cuenta</label>
          <select name="tipoCuenta" class="form-select">
             <%
            List<TipoDeCuenta> tipos = (List<TipoDeCuenta>) request.getAttribute("tipoCuenta");
            if (tipos != null) {
                for (TipoDeCuenta tipo : tipos) {
        %>
                    <option value="<%= tipo.getIdTipoCuenta() %>">
                        <%= tipo.getDescripcion() %>
                    </option>
        <%
                }
            } else {
        %>
            <option value="">No hay tipos disponibles</option>
        <%
            }
        %>
          </select>
        </div>

        <!-- Número de cuenta -->
        <div class="mb-3">
          <label for="numeroCuenta" class="form-label">Número de Cuenta</label>
          <input type="text" class="form-control readonly" name="txtNumeroCuenta" id="numeroCuenta" value="<%= request.getAttribute("numeroCuenta") != null ? request.getAttribute("numeroCuenta") : "" %>" required>
          <div class="invalid-feedback-icon" id="cuentaFeedback">
            <i class="fas fa-exclamation-circle"></i>
            Debe tener entre 11 y 13 dígitos.
          </div>
        </div>

        <!-- CBU -->
        <div class="mb-3">
          <label for="cbu" class="form-label">CBU</label>
          <input type="text" class="form-control readonly" name="txtCbu" id="cbu" value="<%= request.getAttribute("cbu") != null ? request.getAttribute("cbu") : "" %>" required>
          <div class="invalid-feedback-icon" id="cbuFeedback">
            <i class="fas fa-exclamation-circle"></i>
            Debe tener exactamente 22 dígitos.
          </div>
        </div>

        <!-- Saldo -->
        <div class="mb-3">
          <label for="saldo" class="form-label">Saldo</label>
          <input type="text" class="form-control readonly" id="saldo" value="$10.000" readonly>
        </div>

        <!-- Estado -->
        <div class="mb-3">
          <label for="estado" class="form-label">Estado</label>
          <input type="text" class="form-control readonly" id="estado" value="Activa" readonly>
        </div>

        <!-- Botones de acción -->
        <div class="d-flex justify-content-end gap-3 mt-4">
          <a type="button" class="btn btn-outline-secondary" href="ListarCuentasServlet" ><i class="bi bi-backspace"></i> Volver</a>
          <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalGuardar">
            <i class="fas fa-save me-1"></i> Registar
          </button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="location.href='ListarCuentasServlet'">
            <i class="fas fa-trash-alt me-1"></i> Cancelar
          </button>
        </div>

        <!-- Modal Confirmación de Guardado -->
        <div class="modal fade" id="modalGuardar" tabindex="-1" aria-labelledby="modalGuardarLabel" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="modalGuardarLabel">Confirmar registro</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
              </div>
              <div class="modal-body">
                ¿Deseás registrar esta cuenta?
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-primary" name="btnAceptar" value="Aceptar">Registrar</button>
              </div>
            </div>
          </div>
        </div>
      </form>
    </div>
  </main>

<%
    String mensajeExito = (String) request.getAttribute("mensajeExito");
    String mensajeError = (String) request.getAttribute("mensajeError");
%>
<!-- Toast Notificación -->
<div class="position-fixed top-0 end-0 p-4" style="z-index: 1055;">
  <div id="toastNotificacion" class="toast align-items-center text-bg-<%= (mensajeExito != null ? "success" : "danger") %> border-0" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="d-flex">
      <div class="toast-body fs-5 fw-semibold">
        <%= mensajeExito != null ? mensajeExito : mensajeError != null ? mensajeError : "" %>
      </div>
      <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Cerrar"></button>
    </div>
  </div>
</div>
<jsp:include page="Footer.html" />
<script>
  window.addEventListener('DOMContentLoaded', function () {
    <% if (mensajeExito != null || mensajeError != null) { %>
      var toastEl = document.getElementById('toastNotificacion');
      var toast = new bootstrap.Toast(toastEl);
      toast.show();
    <% } %>

    const cuentaInput = document.getElementById("numeroCuenta");
    const cbuInput = document.getElementById("cbu");
    const cuentaFeedback = document.getElementById("cuentaFeedback");
    const cbuFeedback = document.getElementById("cbuFeedback");

    cuentaInput.addEventListener("input", () => {
      const value = cuentaInput.value;
      const isInvalid = value.length < 11 || value.length > 13 || !/^\d+$/.test(value);
      cuentaInput.classList.toggle("input-error", isInvalid);
      cuentaFeedback.style.display = isInvalid ? "flex" : "none";
    });

    cbuInput.addEventListener("input", () => {
      const value = cbuInput.value;
      const isInvalid = value.length !== 22 || !/^\d+$/.test(value);
      cbuInput.classList.toggle("input-error", isInvalid);
      cbuFeedback.style.display = isInvalid ? "flex" : "none";
    });
  });
</script>
</body>
</html>