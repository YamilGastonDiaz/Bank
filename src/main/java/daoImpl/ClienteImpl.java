package daoImpl;
 
 
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
 
import conexion.Conexion;
 
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
 
import dao.ClienteDao;
import entidad.Cliente;
import entidad.Localidad;
import entidad.Provincia;
import entidad.TipoUser;
import entidad.Usuario;
 
public class ClienteImpl implements ClienteDao{
 
	private static final String insert = "Insert into clientes\r\n"
			+ "(dni, cuil, nombre, apellido, sexo, nacionalidad, fechanacimiento, direccion, id_localidad, correo, telefono, fecha_alta) \r\n"
			+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String readall =  "select * from vista_clientes";
	private static final String READ_ONE_BY_ID = "SELECT * FROM vista_clientes WHERE id_cliente = ?";
	private static final String query = "SELECT u.nombreusuario FROM cuentas c " +
            "JOIN usuarios u ON c.id_usuario = u.id_usuario " +
            "WHERE c.num_de_cuenta = ?";
	private static final String query2 = "SELECT * FROM vista_clientes WHERE id_cliente = ?";
	private static final String sql = "{CALL ActualizarCliente(?, ?, ?, ?, ?)}";
	private static final String query3 = "SELECT * FROM vista_clientes WHERE id_usuario = ?";
 
 
 
	public Cliente ReadOne(int idCliente) {
        PreparedStatement statement;
        ResultSet resultSet;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        Cliente cliente = null; 
 
        try {
            statement = conexion.prepareStatement(READ_ONE_BY_ID);
            statement.setInt(1, idCliente);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                cliente = getCliente(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cliente;
    }
 
	@Override
	public List<Cliente> ReadAll() {
		PreparedStatement statement;
		ResultSet resultSet; 
		Connection conexion = Conexion.getConexion().getSQLConexion();
		ArrayList<Cliente> cliente = new ArrayList<Cliente>();
 
		try 
		{
			statement = conexion.prepareStatement(readall);
			resultSet = statement.executeQuery();
			while(resultSet.next())
			{
				cliente.add(getCliente(resultSet));
			}
		} 
		catch (SQLException e) 
		{
			 System.err.println("Error al leer la base de datos: tabla Clientes");
			 e.printStackTrace();
		}
 
		return cliente;
	}
 
	public int Insert(Cliente cliente) {
		PreparedStatement statement;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		int idGenerado = -1;
 
		try {
			statement = conexion.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS);
			statement.setString(1, cliente.getDni());
			statement.setString(2, cliente.getCuil());
			statement.setString(3, cliente.getNombre());
			statement.setString(4, cliente.getApellido());
			statement.setString(5, String.valueOf(cliente.getSexo())); 
			statement.setString(6, cliente.getNacionalidad());
			statement.setDate(7, Date.valueOf(cliente.getFechaNacimiento())); 
			statement.setString(8, cliente.getDireccion());
			statement.setInt(9, cliente.getLocalidad().getIdLocalidad());
			statement.setString(10, cliente.getCorreo());
			statement.setString(11, cliente.getTelefono());
			statement.setDate(12, Date.valueOf(cliente.getFechaAlta()));
 
			if (statement.executeUpdate() > 0) {
				ResultSet rs = statement.getGeneratedKeys();
				if (rs.next()) {
					idGenerado = rs.getInt(1); 
				}
				conexion.commit();
			}
		}
 
		catch(SQLException e) {
			e.printStackTrace();
		}
 
		return idGenerado;
 
	}
 
	@Override
	public boolean update(Cliente cliente) {
		CallableStatement cs = null;
		Connection conexion = Conexion.getConexion().getSQLConexion();
        boolean seActualizo = false;
 
        try {           
            cs = conexion.prepareCall(sql);
            cs.setInt(1, cliente.getIdCliente());
            cs.setString(2, cliente.getDireccion());
            cs.setInt(3, cliente.getLocalidad().getIdLocalidad());
            cs.setString(4, cliente.getCorreo());
            cs.setString(5, cliente.getTelefono());
 
            int filasAfectadas = cs.executeUpdate();
            System.out.println("DAO: Filas afectadas por la actualización: " + filasAfectadas);
 
            if (filasAfectadas > 0) {
                System.out.println("DAO: La actualización fue exitosa. Haciendo commit...");
                conexion.commit();
                seActualizo = true;
            } else {
                 System.out.println("DAO: No se afectaron filas. Haciendo rollback.");
                 conexion.rollback();
            }
        } catch (SQLException e) {
            System.err.println("DAO: ¡ERROR! Ocurrió una SQLException al actualizar.");
            e.printStackTrace(); 
            try {
                conexion.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        }
        return seActualizo;
	}
 
	@Override
	public Cliente getClientePorID(int id) {
		Cliente cliente = null;
	    PreparedStatement stmt;
	    ResultSet rs;
	    Connection conn = Conexion.getConexion().getSQLConexion();
 
	    try {
	        stmt = conn.prepareStatement(query2);
	        stmt.setInt(1, id);
	        rs = stmt.executeQuery();
 
	        if (rs.next()) {
	            cliente = getCliente(rs);
	        }
 
	    } catch (SQLException e) {
	        System.err.println("Error al obtener cliente por ID: " + e.getMessage());
	        e.printStackTrace();
	    }
 
	    return cliente;
 
 
	}
 
	public Cliente getCliente(ResultSet resultSet) throws SQLException {
		// Provincia
	    short idProvincia = resultSet.getShort("id_provincia");
	    String nombreProvincia = resultSet.getString("provincia");
	    Provincia provincia = new Provincia(idProvincia, nombreProvincia);
 
	    // Localidad
	    short idLocalidad = resultSet.getShort("id_localidad");
	    String nombreLocalidad = resultSet.getString("localidad");
	    Localidad localidad = new Localidad(idLocalidad, nombreLocalidad, provincia);
 
	    // Usuario (puede ser null)
	    int idUsuario = resultSet.getInt("id_usuario");
	    byte idTipoUser = resultSet.getByte("id_tipouser");
	    String descTipoUser = resultSet.getString("descUsuario");
	    String nombreUsuario = resultSet.getString("nombreusuario");
	    String contrasenia = resultSet.getString("contrasenia");
	    boolean estadoUsuario = resultSet.getBoolean("estadoUsuario");
	    TipoUser tipoUser = new TipoUser(idTipoUser, descTipoUser);
	    Usuario usuario = new Usuario(idUsuario, 0, nombreUsuario, contrasenia, tipoUser, estadoUsuario);
 
	    // Cliente
	    int idCliente = resultSet.getInt("id_cliente");
	    String dni = resultSet.getString("dni");
	    String cuil = resultSet.getString("cuil");
	    String nombre = resultSet.getString("nombre");
	    String apellido = resultSet.getString("apellido");
 
	    String sexoStr = resultSet.getString("sexo");
	    char sexo = (sexoStr != null && !sexoStr.isEmpty()) ? sexoStr.charAt(0) : 'N';
 
	    String nacionalidad = resultSet.getString("nacionalidad");
 
	    Date fechaNacSQL = resultSet.getDate("fechanacimiento");
	    LocalDate fechaNacimiento = (fechaNacSQL != null) ? fechaNacSQL.toLocalDate() : null;
 
	    String direccion = resultSet.getString("direccion");
	    String correo = resultSet.getString("correo");
	    String telefono = resultSet.getString("telefono");
	    Date fechaAltaSQL = resultSet.getDate("altaCliente");
	    LocalDate fechaAlta = (fechaAltaSQL != null) ? fechaAltaSQL.toLocalDate() : null;
	    boolean estado = resultSet.getBoolean("estadoUsuario");
	    boolean tienePrestamoActivo = false;
	    try {
	        tienePrestamoActivo = resultSet.getBoolean("tienePrestamoActivo");
	    } catch (SQLException e) {
	        // Si no está en la vista, lo dejamos en false por defecto
	    }
 
	    // Construcción final del objeto Cliente
	    Cliente cliente = new Cliente(
	        idCliente,
	        dni,
	        cuil,
	        nombre,
	        apellido,
	        sexo,
	        nacionalidad,
	        fechaNacimiento,
	        direccion,
	        localidad,
	        correo,
	        telefono,
	        usuario,
	        fechaAlta,
	        estado
	    );
	    cliente.setTienePrestamoActivo(tienePrestamoActivo);
 
	    return cliente;
	}
 
	@Override
	public Cliente getPorIdUsuario(int idUsuario) {
	    Cliente cliente = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    Connection conexion = Conexion.getConexion().getSQLConexion();
 
	    try {
	        stmt = conexion.prepareStatement(query3);
	        stmt.setInt(1, idUsuario);
	        rs = stmt.executeQuery();
 
	        if (rs.next()) {
	            cliente = getCliente(rs);
	        }
 
	    } catch (SQLException e) {
	        System.err.println("Error al obtener cliente por ID de usuario: " + e.getMessage());
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (stmt != null) stmt.close();
	        } catch (SQLException ex) {
	            ex.printStackTrace();
	        }
	    }
 
	    return cliente;
	}
 
	public String getUsuarioPorCuenta(String numCuenta) {
	    String nombreUsuario = "";
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
 
	    try {
	        Connection conn = Conexion.getConexion().getSQLConexion();
	        stmt = conn.prepareStatement(query);
	        stmt.setString(1, numCuenta);
	        rs = stmt.executeQuery();
 
	        if (rs.next()) {
	            nombreUsuario = rs.getString("nombreusuario");
	        }
 
	    } catch (SQLException e) {
	        System.err.println("Error al obtener nombre de usuario por cuenta: " + e.getMessage());
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (stmt != null) stmt.close();
	        } catch (SQLException ex) {
	            ex.printStackTrace();
	        }
	    }
 
	    return nombreUsuario;
	}
 
}

