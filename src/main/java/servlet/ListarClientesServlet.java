package servlet;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidad.Cliente;
import negocioImpl.negocioClienteImpl;

@WebServlet("/listarClientes")
public class ListarClientesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String filtroEstado = request.getParameter("estado");
        String filtroTexto = request.getParameter("busqueda");

        negocioClienteImpl negocio = new negocioClienteImpl();
        List<Cliente> clientesList = negocio.ReadAll();

        // Filtrar por estado
        if (filtroEstado != null && !filtroEstado.isEmpty()) {
            boolean activo = filtroEstado.equals("activo");
            clientesList = clientesList.stream()
                    .filter(c -> c.Estado() == activo)
                    .collect(Collectors.toList());
        }

        // Filtrar por texto
        if (filtroTexto != null && !filtroTexto.isEmpty()) {
            String textoLower = filtroTexto.toLowerCase();
            clientesList = clientesList.stream()
                    .filter(c -> (c.getNombre() != null && c.getNombre().toLowerCase().contains(textoLower)) ||
                                 (c.getApellido() != null && c.getApellido().toLowerCase().contains(textoLower)) ||
                                 String.valueOf(c.getDni()).contains(textoLower))
                    .collect(Collectors.toList());
        }

        request.setAttribute("listaUsuarios", clientesList);
        request.setAttribute("estadoSeleccionado", filtroEstado);
        request.setAttribute("busqueda", filtroTexto);
        request.getRequestDispatcher("ListaUser.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
