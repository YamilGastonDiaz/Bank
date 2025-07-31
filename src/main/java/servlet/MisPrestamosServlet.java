package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidad.Prestamo;
import entidad.Usuario;
import negocioImpl.negocioPrestamoImpl;


@WebServlet("/MisPrestamosServlet")
public class MisPrestamosServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String estadoFiltro = request.getParameter("estado");
        
        negocioPrestamoImpl negocioPrestamoImpl = new negocioPrestamoImpl();
        List<Prestamo> todos = negocioPrestamoImpl.readAllByClienteId(usuario.getIdcliente());
        List<Prestamo> filtrados = new ArrayList<>();

        if (estadoFiltro == null || estadoFiltro.isEmpty()) {
            filtrados = todos;
        } else {
            for (Prestamo p : todos) {
                boolean coincide = switch (estadoFiltro) {
                    case "Pendiente de aprobación" -> !p.isEstado();
                    case "Activo" -> p.isEstado() && p.isAprobado() && !p.isFinalizado();
                    case "Rechazado" -> p.isEstado() && !p.isAprobado();
                    case "Finalizado" -> p.isFinalizado();
                    default -> true;
                };
                if (coincide) filtrados.add(p);
            }
        }

        request.setAttribute("listaPrestamos", filtrados);
        request.setAttribute("estadoSeleccionado", estadoFiltro); // para mantener el valor en el select
        request.getRequestDispatcher("/ListadoDePrestamos.jsp").forward(request, response);
    }
}
