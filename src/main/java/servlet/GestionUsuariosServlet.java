package servlet; 

import java.io.IOException;

import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import entidad.Usuario;
import negocio.negocioUsuario;
import negocioImpl.negocioUsuarioImpl;

@WebServlet("/admin/usuarios")
public class GestionUsuariosServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public GestionUsuariosServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
        	negocioUsuario usuarioNegocio = new negocioUsuarioImpl();
            List<Usuario> listaUsuarios = usuarioNegocio.ReadAll();
            
            request.setAttribute("listaUsuarios", listaUsuarios);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("/ListaUser.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
        
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            
            if ("delete".equals(action)) {
                int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
                
                negocioUsuario usuarioNegocio = new negocioUsuarioImpl();
                usuarioNegocio.logicalDelete(idUsuario);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/listarClientes");

    }
}
