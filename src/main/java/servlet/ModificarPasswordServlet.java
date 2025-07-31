package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import negocioImpl.negocioUsuarioImpl;
import entidad.Usuario;

@WebServlet("/ModificarPasswordServlet")
public class ModificarPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private negocioUsuarioImpl usuarioImpl = new negocioUsuarioImpl();
    
    public ModificarPasswordServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
            System.out.println("Usuario en sesión: " + usuario);
            if (usuario == null) {
                response.sendRedirect("InicioSesion.jsp");
                return;
            }

            String accion = request.getParameter("accion");

            if ("cambiarPasswordForm".equals(accion)) {
                String actual = request.getParameter("actual");
                String nuevaContrasenia = request.getParameter("nueva");
                String confirmarContrasenia = request.getParameter("confirmar");

                boolean datosOK = true;
                String mensajeError = "";

                if (actual == null || actual.trim().isEmpty()) {
                    mensajeError += "Debe ingresar su contraseña actual.<br>";
                    datosOK = false;
                }

                if (nuevaContrasenia == null || nuevaContrasenia.trim().isEmpty()) {
                    mensajeError += "Se espera el ingreso de la nueva contraseña.<br>";
                    datosOK = false;
                } else if (!nuevaContrasenia.matches("^[a-zA-Z0-9]{8,}$")) {
                    mensajeError += "La nueva contraseña debe ser alfanumérica, sin espacios y con al menos 8 caracteres.<br>";
                    datosOK = false;
                }

                if (confirmarContrasenia == null || confirmarContrasenia.trim().isEmpty()) {
                    mensajeError += "Debe confirmar la nueva contraseña.<br>";
                    datosOK = false;
                } else if (!nuevaContrasenia.equals(confirmarContrasenia)) {
                    mensajeError += "La nueva contraseña y su confirmación no coinciden.<br>";
                    datosOK = false;
                }

                if (datosOK) {
                    boolean coincide = usuarioImpl.verificarPassword(usuario.getNombreUsuario(), actual);
                    if (!coincide) {
                        mensajeError += "La contraseña actual es incorrecta.<br>";
                        datosOK = false;
                    }
                }

                if (datosOK) {
                	System.out.println("Actualizando contraseña del usuario: " + usuario + " con nueva clave: " + nuevaContrasenia);
                    boolean actualizada = usuarioImpl.modificarPassword(nuevaContrasenia, usuario.getNombreUsuario());

                    if (actualizada) {
                        request.setAttribute("mensajeExito", "Contraseña actualizada correctamente");
                    } else {
                        request.setAttribute("mensajeError", "Ocurrió un error al actualizar la contraseña.");
                    }
                } else {
                    request.setAttribute("mensajeError", mensajeError);
                }

                request.getRequestDispatcher("ModificarContraseña.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("ModificarContraseña.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensajeError", "Error inesperado: " + e.getMessage());
            request.getRequestDispatcher("ModificarContraseña.jsp").forward(request, response);
        }
    }

}