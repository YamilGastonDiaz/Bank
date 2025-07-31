<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="entidad.Cliente"%>
<%@ include file="fragmentos/VerificarSesion.jspf"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Administración de Clientes</title>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" 
    href="https://cdn.datatables.net/2.3.2/css/dataTables.bootstrap5.min.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/2.3.2/js/dataTables.js"></script>
<script
    src="https://cdn.datatables.net/2.3.2/js/dataTables.bootstrap5.min.js"></script>
<style>
html, body {
    height: 100%;
    margin: 0;
    display: flex;
    flex-direction: column;
}

body {
    background-color: #f8f9fa;
    background-image: url('assets/bg1.jpg');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    flex: 1;
    overflow-x: hidden;
}

main.container-fluid {
    background-color: #ffffff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-top: 30px;
    margin-bottom: 30px;
    flex-grow: 1;
    max-width: 95%;
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
    overflow-x: auto; 
    width: 100%;
}

table{
    min-width: 1200px;
}
</style>
</head>
<body>

    <jsp:include page="Nav.jsp" />
    <main class="container-fluid">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap">
            <div class="d-flex align-items-center gap-3">
                <i class="bi bi-person-lines-fill fs-1 text-primary"></i> 
            <div>
            <h2 class="fw-bold mb-0"> Administración de Clientes</h2>
                 <small class="text-muted">Gestione altas, bajas y modificaciones de clientes</small>
                </div>
                </div>
            <a href="InsertarUserClienteServlet?action=alta" class="btn btn-primary btn-lg mt-3 mt-md-0">
  <i class="fas fa-plus-circle mw-2"></i> Agregar Usuario
</a>
        </div>

<form action="listarClientes" method="get" class="row g-3 mb-4">
  <div class="col-md-4">
    <label for="busqueda" class="form-label">Buscar por Nombre, Apellido o DNI</label>
    <input type="text" class="form-control" id="busqueda" name="busqueda"
      value="<%= request.getParameter("busqueda") != null ? request.getParameter("busqueda") : "" %>">
  </div>
  <div class="col-md-3">
    <label for="estado" class="form-label">Estado</label>
    <select name="estado" id="estado" class="form-select">
      <option value="" <%= request.getParameter("estado") == null ? "selected" : "" %>>Todos</option>
      <option value="activo" <%= "activo".equals(request.getParameter("estado")) ? "selected" : "" %>>Activo</option>
      <option value="inactivo" <%= "inactivo".equals(request.getParameter("estado")) ? "selected" : "" %>>Inactivo</option>
    </select>
  </div>
  <div class="col-md-3 d-flex align-items-end">
    <button type="submit" class="btn btn-primary w-100 me-2">Filtrar</button>
    <a href="listarClientes" class="btn btn-secondary w-100">Limpiar</a>
  </div>
</form>

        <%
        List<Cliente> listaUsuarios = (List<Cliente>) request.getAttribute("listaUsuarios");
        %>

        <div class="table-responsive">
            <table id="clientesTable"
                class="table table-striped table-hover w-100">
                <thead class="table-dark">
                    <tr>
                        <th class="text-center">DNI</th>
                        <th class="text-center">CUIL</th>
                        <th class="text-center">NOMBRE</th>
                        <th class="text-center">APELLIDO</th>
                        <th class="text-center">NACIONALIDAD</th>
                        <th class="text-center">FECHA NAC</th>
                        <th class="text-center">DIRECCION</th>
                        <th class="text-center">LOCALIDAD</th>
                        <th class="text-center">TELEFONO</th>
                        <th class="text-center">FECHA ALTA</th>
                        <th class="text-center">ESTADO</th>
                        <th class="text-center">Editar</th>
                        <th class="text-center">Eliminar</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    if (listaUsuarios != null) {
                        for (Cliente c : listaUsuarios) {
                            if (c == null)
                        continue;
                    %>
                    <tr>
                        <td><%=c.getDni()%></td>
                        <td><%=c.getCuil()%></td>
                        <td><%=c.getNombre()%></td>
                        <td><%=c.getApellido()%></td>
                        <td><%=c.getNacionalidad()%></td>
                        <td><%=c.getFechaNacimiento()%></td>
                        <td><%=c.getDireccion()%></td>
                        <td><%=c.getLocalidad().getDescripcion()%></td>
                        <td><%=c.getTelefono()%></td>
                        <td><%=c.getFechaAlta()%></td>
                        <td><%=c.Estado() ? "<span class='badge bg-success'>Activo</span>" : "<span class='badge bg-danger'>Inactivo</span>"%>
                        </td>

                        <td>
                            <%
                            if (c.getUser() != null) {
                            %> <a
                            href="perfil?action=edit&idUsuario=<%=c.getUser().getIdUsuario()%>"
                            class="btn btn-outline-primary btn-sm btn-action" title="Editar"> <i
                                class="bi bi-pencil-square"></i>
                        </a> <%
             }
             %>
                        </td>

                        <td>
					    <% if (c.isTienePrestamoActivo()) { %>
					        <button type="button"
					            class="btn btn-outline-secondary btn-sm btn-action disabled"
					            style="opacity: 0.6; cursor: not-allowed;"
					            title="No se puede eliminar, tiene préstamos activos">
					            <i class="bi bi-trash3-fill text-secondary"></i>
					        </button>
					    <% } else { %>
					        <!-- Botón que dispara el modal -->
					        <button type="button" class="btn btn-outline-danger btn-sm btn-action" 
					                data-bs-toggle="modal" 
					                data-bs-target="#confirmarEliminarModal<%=c.getUser().getIdUsuario()%>">
					            <i class="bi bi-trash"></i>
					        </button>
					
					        <!-- Modal de confirmación -->
					        <div class="modal fade" id="confirmarEliminarModal<%=c.getUser().getIdUsuario()%>" 
					             tabindex="-1" aria-labelledby="confirmarEliminarLabel<%=c.getUser().getIdUsuario()%>" 
					             aria-hidden="true">
					            <div class="modal-dialog modal-dialog-centered">
					                <div class="modal-content">
					                    <form action="<%=request.getContextPath()%>/admin/usuarios" method="post">
					                        <div class="modal-header">
					                            <h5 class="modal-title" id="confirmarEliminarLabel<%=c.getUser().getIdUsuario()%>">
					                                Confirmar Eliminación
					                            </h5>
					                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
					                        </div>
					                        <div class="modal-body">
					                            ¿Estás seguro que deseas eliminar al usuario <strong><%=c.getNombre()%> <%=c.getApellido()%></strong>?
					                        </div>
					                        <div class="modal-footer">
					                            <input type="hidden" name="action" value="delete" />
					                            <input type="hidden" name="idUsuario" value="<%=c.getUser().getIdUsuario()%>" />
					                            <button type="submit" class="btn btn-danger">Sí, eliminar</button>
					                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
					                        </div>
					                    </form>
					                </div>
					            </div>
					        </div>
					    <% } %>
					</td>

                        <%
                        }
                        }
                        %>
                    
                </tbody>
            </table>
        </div>
    </main>

    <jsp:include page="Footer.html" />
    <script>
        $(document)
                .ready(function() {
                	$('#clientesTable').DataTable({
                    "paging" : true,
                    "pageLength" : 10,
                    "lengthChange" : false,
                     "searching" : false,
                     "ordering" : true,
                     "info" : true,
                     "autoWidth" : false,
                     "scrollX" : true,
                     "language" : {
                     "url" : "https://cdn.datatables.net/plug-ins/1.13.1/i18n/es-ES.json"
                     }
                   });
               });
    </script>
</body>
</html>