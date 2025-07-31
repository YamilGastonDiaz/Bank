<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="entidad.Localidad" %>
<%@page import="entidad.Provincia" %>

<%@ include file="fragmentos/VerificarSesion.jspf"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Registro de Usuario - Novabank</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="Styles.css"/>
</head>
<body>
<jsp:include page="Nav.jsp" />

<div class="bg-gradient-custom min-vh-100 d-flex justify-content-center align-items-center py-5">
  <div class="container">
    <div class="row align-items-center">
      
      <!-- Imagen a la izquierda -->
      <div class="col-md-6 text-center mb-4 mb-md-0">
        <img src="assets/registroNuevoCliente.png" alt="Registro Novabank" class="img-left img-fluid">
      </div>

      <!-- Formulario a la derecha -->
      <div class="col-md-6">
        <div class="form-container">

          <div class="text-center mb-4">
            <h2 class="fw-bold text-primary">Crea una nueva cuenta</h2>
            <p class="text-muted">Completa los campos para dar de alta un usuario</p>
          </div>

          <form action="InsertarUserClienteServlet" method="post" class="row g-3">
			
			
            <div class="col-md-6">
              <label for="txtCUIL" class="form-label">CUIL</label>
              <input id="txtCUIL"name="txtCUIL" class="form-control rounded-pill bg-light border-0" type="text" placeholder="Ingrese CUIL" value="<%= request.getAttribute("cuil") != null ? request.getAttribute("cuil") : "" %>" />
            </div>

            <div class="col-md-6">
              <label for="txtNombreUsuario" class="form-label">Nombre</label>
              <input name="txtNombreUsuario" class="form-control rounded-pill bg-light border-0" type="text" placeholder="Nombre completo" value="<%= request.getAttribute("nombre") != null ? request.getAttribute("nombre") : "" %>"/>
            </div>

            <div class="col-md-6">
              <label for="txtApellidoUsuario" class="form-label">Apellido</label>
              <input name="txtApellidoUsuario" class="form-control rounded-pill bg-light border-0" type="text" placeholder="Apellido" value="<%= request.getAttribute("apellido") != null ? request.getAttribute("apellido") : "" %>"/>
            </div>

            <div class="col-md-6">
              <label for="ddlSexo" class="form-label">Sexo</label>
              <select name="ddlSexo"  id="ddlSexo" class="form-select rounded-pill bg-light border-0" required>
                <option value="" disabled selected>Seleccione</option>
                <option value="F" <%= "F".equals(request.getAttribute("sexo")) ? "selected" : "" %>>Femenino</option>
                <option value="M" <%= "M".equals(request.getAttribute("sexo")) ? "selected" : "" %>>Masculino</option>
              </select>
            </div>

            <div class="col-md-6">
              <label for="txtNacionalidad" class="form-label">Nacionalidad</label>
              <input name="txtNacionalidad" class="form-control rounded-pill bg-light border-0" type="text" value="<%= request.getAttribute("nacionalidad") != null ? request.getAttribute("nacionalidad") : "" %>"  />
            </div>

            <div class="col-md-6">
              <label for="txtFechaNac" class="form-label">Fecha de Nacimiento</label>
              <input name="txtFechaNac" class="form-control rounded-pill bg-light border-0" type="date" value="<%= request.getAttribute("fechaNacimiento") != null ? request.getAttribute("fechaNacimiento") : "" %>" />
            </div>

            <div class="col-md-6">
              <label for="txtDomicilio" class="form-label">Domicilio</label>
              <input name="txtDomicilio" class="form-control rounded-pill bg-light border-0" type="text" placeholder="Dirección" value="<%= request.getAttribute("direccion") != null ? request.getAttribute("direccion") : "" %>" />
            </div>

			
            <div class="col-md-6">
              <label for="Localidad" class="form-label">Localidad</label>
			<select name="Localidad" class="form-select">
		    <%
		    String idLocalidadSel = (String) request.getAttribute("idLocalidadSeleccionada");
		        List<Localidad> localidades = (List<Localidad>) request.getAttribute("localidades");
		        if (localidades != null && !localidades.isEmpty()) {
		            for (Localidad local : localidades) {
		            	 boolean seleccionado = idLocalidadSel != null && idLocalidadSel.equals(String.valueOf(local.getIdLocalidad()));
		    %>
		                <option value="<%= local.getIdLocalidad() %>" <%= seleccionado ? "selected" : "" %>>
		                	<%= local.getDescripcion() %>
		                </option>
		    <%
		            }
		        } else {
		    %>
		        <option value="">No hay Localidades disponibles</option>
		    <%
		        }
		    %>
		</select>
            </div>

            <div class="col-md-6">
              <label for="Provincia" class="form-label">Provincia</label>
			<select id="Provincia" name="Provincia" class="form-select">
		    <%
		    String idProvinciaSel = (String) request.getAttribute("idProvinciaSeleccionada");
		        List<Provincia> provincias = (List<Provincia>) request.getAttribute("provincias");
            		if (provincias != null) {
            		  for (Provincia provincia : provincias) {
		            	boolean seleccionado = idProvinciaSel != null && idProvinciaSel.equals(String.valueOf(provincia.getIdProvincia()));
		    %>
		                <option value="<%= provincia.getIdProvincia() %>" <%= seleccionado ? "selected" : "" %>>
		                	<%= provincia.getDescripcion() %>
		                </option>
		    <%
		            }
		     } else {
    		%>
      			<option value="">No hay Provincias disponibles</option>
    		<% } %>
		</select>
            </div>

            <div class="col-md-6">
              <label for="txtEmail" class="form-label">Correo Electrónico</label>
              <input name="txtEmail" class="form-control rounded-pill bg-light border-0" type="email" placeholder="nombre@ejemplo.com" value="<%= request.getAttribute("txtEmail") != null ? request.getAttribute("txtEmail") : "" %>"/>
            </div>

            <div class="col-md-6">
              <label for="txtTelefono" class="form-label">Teléfono</label>
              <input name="txtTelefono" class="form-control rounded-pill bg-light border-0" type="tel" placeholder="Teléfono" value="<%= request.getAttribute("txtTelefono") != null ? request.getAttribute("txtTelefono") : "" %>" />
            </div>
            
             <div class="col-md-6">
              <label for="txtDNI" class="form-label">DNI</label>
              <input id="txtDNI" name="txtDNI" class="form-control rounded-pill bg-light border-0" type="text" placeholder="Ingrese DNI" value="<%= request.getAttribute("txtDNI") != null ? request.getAttribute("txtDNI") : "" %>"/>
            </div>
            
 			<div class="border row g-3 mt-3">
 			  <div class="col-md-6">
              <label for="txtUsuario" class="form-label">Usuario</label>
              <input name="txtUsuario" class="form-control rounded-pill bg-light border-0" type="text" placeholder="Nombre de usuario:" value="<%= request.getAttribute("nombreUsuario") != null ? request.getAttribute("nombreUsuario") : "" %>" />
            </div>
			
            <div class="col-md-6">
              <label for="txtContrasenia" class="form-label">Contraseña</label>
              <input name="txtContrasenia" class="form-control rounded-pill bg-light border-0" type="password" placeholder="Mínimo 8 caracteres" />
            </div>

            <div class="col-md-6 mb-2">
              <label for="txtContraseniaC" class="form-label">Confirmar Contraseña</label>
              <input name="txtContraseniaC" class="form-control rounded-pill bg-light border-0" type="password" placeholder="Confirmar contraseña" />
            </div>
 			</div>

			<div id="errorMensaje" class="alert alert-danger d-none" role="alert"></div>
			
            <!-- Botones -->
            <div class="col-12 d-grid gap-2 mt-3">
              <button type="submit" class="btn btn-primary btn-lg rounded-pill">Guardar</button>
              <button type="reset" class="btn btn-outline-secondary btn-lg rounded-pill" >Cancelar</button>
            </div>

          </form>
        </div>
      </div>
    </div>
  </div>
</div>

    	<% if (request.getAttribute("mensajeError") != null) { %>
    	<div class="alert alert-danger" role="alert">
    	<%= request.getAttribute("mensajeError") %>
    	</div>
	<%
    	} else if (request.getAttribute("mensajeExito") != null) { %>
    		<div class="alert alert-success" role="alert">
    	<%=request.getAttribute("mensajeExito") %>
    	</div>
	<% }%>
<jsp:include page="Footer.html" />

</body>
</html>