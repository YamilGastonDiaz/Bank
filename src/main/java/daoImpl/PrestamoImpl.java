package daoImpl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import conexion.Conexion;
import dao.PrestamoDao;
import entidad.Prestamo;


public class PrestamoImpl implements PrestamoDao {

    private static final String insertPrestamo = "INSERT INTO prestamos (num_de_cuenta, fecha, importe_pedido, cuotas, importe_mensual, estado, aprobado, finalizado) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String readById = "SELECT * FROM vista_prestamos WHERE id = ?";
    private static final String updateEstado = "UPDATE prestamos SET estado = ?, aprobado = ?, finalizado = ? WHERE id_prestamo = ?";
    private static final String query = "SELECT * FROM vista_prestamos WHERE id_cliente = ? ORDER BY fecha DESC";
    
    @Override
    public boolean insert(Prestamo prestamo) {
        PreparedStatement statement;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        boolean insertExitoso = false;

        try {
            statement = conexion.prepareStatement(insertPrestamo);
            statement.setString(1, prestamo.getNumDeCuenta());
            statement.setDate(2, Date.valueOf(prestamo.getFecha()));
            statement.setDouble(3, prestamo.getImportePedido());
            statement.setShort(4, prestamo.getCuotas());
            statement.setDouble(5, prestamo.getImporteMensual());
            statement.setBoolean(6, prestamo.isEstado());
            statement.setBoolean(7, prestamo.isAprobado());
            statement.setBoolean(8, prestamo.isFinalizado());

            if (statement.executeUpdate() > 0) {
                conexion.commit();
                insertExitoso = true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                conexion.rollback();
            } catch (SQLException e2) {
                e2.printStackTrace();
            }
        }
        return insertExitoso;
    }

    @Override
    public List<Prestamo> readAll() {
        PreparedStatement statement;
        ResultSet resultSet;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        ArrayList<Prestamo> prestamos = new ArrayList<>();
        
        String query = "SELECT * FROM vista_prestamos";

        try {
        	statement = conexion.prepareStatement(query);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                prestamos.add(getPrestamo(resultSet));
            }

        } catch (SQLException e) {
            System.err.println("Error al leer la base de datos");
            e.printStackTrace();
        }
        return prestamos;
    }
    
    @Override
    public Prestamo readById(int idPrestamo) {
        PreparedStatement statement;
        ResultSet resultSet;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        Prestamo prestamo = null;

        try {
            statement = conexion.prepareStatement(readById);
            statement.setInt(1, idPrestamo);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                prestamo = getPrestamo(resultSet);
            }

        } catch (SQLException e) {
            System.err.println("Error al obtener préstamo por ID");
            e.printStackTrace();
        }

        return prestamo;
    }

    public boolean actualizarEstado(Prestamo prestamo) {
        PreparedStatement statement = null;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        boolean actualizado = false;

        try {
            statement = conexion.prepareStatement(updateEstado);
            statement.setBoolean(1, prestamo.isEstado());
            statement.setBoolean(2, prestamo.isAprobado());
            statement.setBoolean(3, prestamo.isFinalizado());
            statement.setInt(4, prestamo.getIdPrestamo());

            actualizado = statement.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error al actualizar estado del préstamo");
            e.printStackTrace();
        } finally {
            try {
                if (statement != null) statement.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return actualizado;
    }


    private Prestamo getPrestamo(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("id");
        String numCuenta = resultSet.getString("NumCuenta");
        LocalDate fecha = resultSet.getDate("fecha").toLocalDate();
        double importePedido = resultSet.getDouble("importePedido");
        short cuotas = resultSet.getShort("cuotas");
        double importeMensual = resultSet.getDouble("importeMensual");
        boolean estado = resultSet.getBoolean("estado");
        boolean aprobado = resultSet.getBoolean("aprobado");
        boolean finalizado = resultSet.getBoolean("finalizado");
        String nombreUsuario = resultSet.getString("nombreusuario");
        int cuotasPagadas = resultSet.getInt("cuotasPagadas");
        
        Prestamo prestamo = new Prestamo(id, numCuenta, nombreUsuario, fecha, importePedido, cuotas, importeMensual, estado, aprobado, finalizado);
        prestamo.setCuotasPagadas(cuotasPagadas);

        return prestamo;
    }
    
    @Override
    public List<Prestamo> readAllByClienteId(int idCliente) {
        PreparedStatement statement;
        ResultSet resultSet;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        ArrayList<Prestamo> prestamos = new ArrayList<>();

        try {
            statement = conexion.prepareStatement(query);
            statement.setInt(1, idCliente);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                prestamos.add(getPrestamo(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return prestamos;
    }
    
}
