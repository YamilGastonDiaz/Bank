package servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CuotaDao;
import daoImpl.CuotaImpl;
import entidad.Cuenta;
import entidad.Cuota;
import entidad.Usuario;
import negocioImpl.negocioCuentaImpl;

@WebServlet("/PrepararPagoCuotaServlet")
public class PrepararPagoCuotaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int idCuota = Integer.parseInt(request.getParameter("idCuota"));
        
        CuotaDao cuotaDao = new CuotaImpl();
        Cuota cuotaAPagar = cuotaDao.readOne(idCuota);
        
        negocioCuentaImpl negocioCuentaImpl = new negocioCuentaImpl();
        List<Cuenta> listaCuentas = negocioCuentaImpl.readAllByClienteId(usuario.getIdcliente());

        request.setAttribute("cuotaAPagar", cuotaAPagar);
        request.setAttribute("listaCuentas", listaCuentas);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/PagoDeCuota.jsp");
        dispatcher.forward(request, response);
    }
}