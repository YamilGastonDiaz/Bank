<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entidad.Localidad" %>
<%@ page import="entidad.Cliente" %>
<%@ include file="fragmentos/VerificarSesion.jspf"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Perfil</title>
    <style>
        body { background-color: #f4f7f6; font-family: 'Inter', sans-serif; }
        .form-card { margin-top: 50px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); border-radius: 15px; background-color: white; }
        .form-label { font-weight: 600; }
    </style>
</head>
<body>

<jsp:include page="Nav.jsp" />

<%
    Cliente cliente = (Cliente) request.getAttribute("cliente");
    List<Localidad> listaLocalidades = (List<Localidad>) request.getAttribute("listaLocalidades");
    if (cliente == null) {
        cliente = new Cliente(); 
    }
%>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-7">
            <div class="form-card">
                <h2 class="text-center mb-4">Editar Mis Datos</h2>
                <form id="formPerfil">
                    <input type="hidden" name="idCliente" value="<%= cliente.getIdCliente() %>">

                    <p><strong>DNI:</strong> <%= cliente.getDni() %></p>
                    <p><strong>Nombre:</strong> <%= cliente.getNombre() %> <%= cliente.getApellido() %></p>
                    <hr>

                    <div class="mb-3">
                        <label for="direccion" class="form-label">Dirección</label>
                        <input type="text" class="form-control" id="direccion" name="direccion" value="<%= cliente.getDireccion() %>" required>
                    </div>
                    <div class="mb-3">
                        <label for="telefono" class="form-label">Teléfono</label>
                        <input type="text" class="form-control" id="telefono" name="telefono" value="<%= cliente.getTelefono() %>" required>
                    </div>
                    <div class="mb-3">
                        <label for="correo" class="form-label">Correo Electrónico</label>
                        <input type="email" class="form-control" id="correo" name="correo" value="<%= cliente.getCorreo() %>" required>
                    </div>
                    <div class="mb-3">
                        <label for="localidad" class="form-label">Localidad</label>
                        <select class="form-select" id="localidad" name="localidad" required>
                            <option value="">-- Seleccione una localidad --</option>
                            <%
                                if (listaLocalidades != null) {
                                    for (Localidad loc : listaLocalidades) {
                                        String selected = "";
                                        if (cliente.getLocalidad() != null && loc.getIdLocalidad() == cliente.getLocalidad().getIdLocalidad()) {
                                            selected = "selected";
                                        }
                                        out.println("<option value='" + loc.getIdLocalidad() + "' " + selected + ">" + loc.getDescripcion() + "</option>");
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                        <a href="listarClientes" class="btn btn-secondary">Cancelar</a>
                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalConfirmarGuardado">
                            Guardar Cambios
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal de confirmación -->
<div class="modal fade" id="modalConfirmarGuardado" tabindex="-1" aria-labelledby="modalConfirmarGuardadoLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="perfil" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalConfirmarGuardadoLabel">Confirmar Guardado</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    ¿Estás seguro de que querés guardar los cambios del perfil?
                </div>
                <div class="modal-footer">
                    <input type="hidden" name="idCliente" value="<%= cliente.getIdCliente() %>">
                    <input type="hidden" id="modalDireccion" name="direccion">
                    <input type="hidden" id="modalTelefono" name="telefono">
                    <input type="hidden" id="modalCorreo" name="correo">
                    <input type="hidden" id="modalLocalidad" name="localidad">

                    <button type="submit" class="btn btn-success">Sí, guardar</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const originalForm = document.getElementById("formPerfil");
        const modalForm = document.querySelector("#modalConfirmarGuardado form");

        document.querySelector('[data-bs-target="#modalConfirmarGuardado"]').addEventListener("click", function () {
            modalForm.querySelector("#modalDireccion").value = originalForm.direccion.value;
            modalForm.querySelector("#modalTelefono").value = originalForm.telefono.value;
            modalForm.querySelector("#modalCorreo").value = originalForm.correo.value;
            modalForm.querySelector("#modalLocalidad").value = originalForm.localidad.value;
        });
    });
</script>

<jsp:include page="Footer.html" />
</body>
</html>