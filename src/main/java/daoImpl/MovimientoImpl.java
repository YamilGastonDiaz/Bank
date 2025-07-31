package daoImpl;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import conexion.Conexion;
import dao.MovimientoDao;
import entidad.Movimiento;
import entidad.TipoDeMovimiento;

public class MovimientoImpl implements MovimientoDao {

    private static final String READ_ALL = "SELECT * FROM movimientos";
    private static final String INSERT = "INSERT INTO movimientos (fecha, detalle, importe, id_tipomovimiento, num_de_cuenta) VALUES (?, ?, ?, ?, ?)";
    private static final String UPDATE = "UPDATE movimientos SET fecha = ?, detalle = ?, importe = ?, id_tipomovimiento = ?, num_de_cuenta = ? WHERE id_movimiento = ?";
    private static final String SELECT_BY_ID = "SELECT * FROM movimientos WHERE id_movimiento = ?";
    private static final String SELECT_TIPO_MOV = "SELECT * FROM tipo_de_movimiento WHERE id_tipomovimiento = ?";
    private static final String SELECT_BY_CUENTA = "SELECT * FROM movimientos WHERE num_de_cuenta = ?";

    @Override
    public List<Movimiento> ReadAll() {
        List<Movimiento> lista = new ArrayList<>();
        Connection conexion = Conexion.getConexion().getSQLConexion();

        try (PreparedStatement ps = conexion.prepareStatement(READ_ALL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Movimiento mov = getDetalleMov(rs);
                if (mov != null) {
                    lista.add(mov);
                }
            }

            System.out.println("Cantidad de movimientos encontrados: " + lista.size());

        } catch (SQLException e) {
            System.err.println("Error al leer movimientos.");
            e.printStackTrace();
        }

        return lista;
    }

    @Override
    public int Insert(Movimiento mov) {
    	Connection conexion = Conexion.getConexion().getSQLConexion();
        int idGenerado = -1;

        try (PreparedStatement ps = conexion.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS)) {

            ps.setDate(1, Date.valueOf(mov.getFecha()));
            ps.setString(2, mov.getDetalle());
            ps.setDouble(3, mov.getImporte());
            ps.setInt(4, mov.getTipoMovimiento().getIdTipoMovimiento());
            ps.setString(5, mov.getNumDeCuenta());

            int filas = ps.executeUpdate();
            if (filas > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        idGenerado = rs.getInt(1);
                    }
                }
            }

        } catch (SQLException e) {
            System.err.println("Error al insertar movimiento.");
            e.printStackTrace();
        }

        return idGenerado;
    }

    @Override
    public boolean update(Movimiento mov) {
    	Connection conexion = Conexion.getConexion().getSQLConexion();
        boolean actualizado = false;

        try (PreparedStatement ps = conexion.prepareStatement(UPDATE)) {

            ps.setDate(1, Date.valueOf(mov.getFecha()));
            ps.setString(2, mov.getDetalle());
            ps.setDouble(3, mov.getImporte());
            ps.setInt(4, mov.getTipoMovimiento().getIdTipoMovimiento());
            ps.setString(5, mov.getNumDeCuenta());
            ps.setInt(6, mov.getIdMovimiento());

            actualizado = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error al actualizar movimiento.");
            e.printStackTrace();
        }

        return actualizado;
    }

    private Movimiento getDetalleMov(ResultSet rs) throws SQLException {
        if (rs == null) return null;

        int id = rs.getInt("id_movimiento");
        LocalDate fecha = rs.getDate("fecha").toLocalDate();
        String detalle = rs.getString("detalle");
        double importe = rs.getDouble("importe");
        int idTipoMov = rs.getInt("id_tipomovimiento");
        String numCuenta = rs.getString("num_de_cuenta");

        TipoDeMovimiento tipo = getIDTipoMov(idTipoMov);

        if (tipo == null) {
            System.err.println("Tipo de movimiento con ID " + idTipoMov + " no encontrado. Movimiento ID: " + id);
            return null;
        }

        return new Movimiento(id, fecha, detalle, importe, tipo, numCuenta);
    }


    @Override
    public Movimiento getMovimientoPorID(int id) {
    	Connection conexion = Conexion.getConexion().getSQLConexion();
        Movimiento mov = null;

        try (PreparedStatement ps = conexion.prepareStatement(SELECT_BY_ID)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    mov = getDetalleMov(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error al obtener movimiento por ID.");
            e.printStackTrace();
        }

        return mov;
    }

    @Override
    public TipoDeMovimiento getIDTipoMov(int tipoMov) {
    	Connection conexion = Conexion.getConexion().getSQLConexion();
        TipoDeMovimiento tipo = null;

        try (PreparedStatement ps = conexion.prepareStatement(SELECT_TIPO_MOV)) {
            ps.setInt(1, tipoMov);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    short id = rs.getShort("id_tipomovimiento");
                    String descripcion = rs.getString("descripcion");
                    tipo = new TipoDeMovimiento(id, descripcion);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error al obtener tipo de movimiento.");
            e.printStackTrace();
        }

        return tipo;
    }

    public List<Movimiento> getMovimientosPorCuenta(String cuenta) {
    	Connection conexion = Conexion.getConexion().getSQLConexion();
        List<Movimiento> lista = new ArrayList<>();

        try (PreparedStatement ps = conexion.prepareStatement(SELECT_BY_CUENTA)) {
            ps.setString(1, cuenta);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Movimiento mov = getDetalleMov(rs);
                    if (mov != null) {
                        lista.add(mov);
                    }
                }
            }

        } catch (SQLException e) {
            System.err.println("Error al obtener movimientos por cuenta.");
            e.printStackTrace();
        }

        return lista;
    }
}