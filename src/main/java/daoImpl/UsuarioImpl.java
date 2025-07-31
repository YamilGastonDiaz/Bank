package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conexion.Conexion;

import java.sql.CallableStatement;

import dao.UsuarioDao;
import entidad.TipoUser;
import entidad.Usuario;
import dao.CuentaDao;

public class UsuarioImpl implements UsuarioDao {
	private static final String insert = "Insert into usuarios\r\n"
			+ "(id_cliente, nombreusuario, contrasenia, id_tipouser) \r\n" + "values(?, ?, ?, ?)";
	private static final String readall = "select * from vista_usuarios";
	private static final String updatePassword = "UPDATE usuarios SET contrasenia = ? WHERE nombreusuario = ?";
	private static final String readPassword = "SELECT * FROM usuarios WHERE nombreusuario = ? AND contrasenia = ?";
	private static final String query1 = readall + " where nombreUsuario = ? and contrasenia = ?";
	private static final String sqlGetClienteId = "SELECT id_cliente FROM usuarios WHERE id_usuario = ?";
	private static final String updateClienteSQL = "UPDATE clientes SET estado = 0 WHERE id_cliente = ?";
	
	@Override
	public List<Usuario> ReadAll() {
		PreparedStatement statement;
		ResultSet resultSet;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
		
		try {
			statement = conexion.prepareStatement(readall);
			resultSet = statement.executeQuery();
			while (resultSet.next()) {
				usuarios.add(getUsuario(resultSet));
			}
		} catch (SQLException e) {
			System.err.println("Error al leer la base de datos:");
			e.printStackTrace();
		}

		return usuarios;
	}

	@Override
	public List<Usuario> ReadAll(int estado) {
		PreparedStatement statement;
		ResultSet resultSet;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
		String query = readall + " where estado = " + estado;
		
		try {
			statement = conexion.prepareStatement(query);
			resultSet = statement.executeQuery();
			while (resultSet.next()) {
				usuarios.add(getUsuario(resultSet));
			}
		} catch (SQLException e) {
			System.err.println("Error al leer la base de datos:");
			e.printStackTrace();
		}

		return usuarios;
	}

	@Override
	public Usuario Read(String usuario, String Pass) {
		Usuario user = new Usuario();
		PreparedStatement statement;
		ResultSet resultSet;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		
		try {
			statement = conexion.prepareStatement(query1);
			statement.setString(1, usuario);
			statement.setString(2, Pass);
			resultSet = statement.executeQuery();
			if (resultSet.next()) {
				user = getUsuario(resultSet);
			}
		} catch (SQLException e) {
			System.err.println("Error al leer la base de datos:");
			e.printStackTrace();
		}

		return user;
	}

	@Override
	public boolean Update(Usuario usuario) {
		Conexion conexion = Conexion.getConexion();
		Connection cn = conexion.getSQLConexion();
		boolean updateExitoso = false;
		CallableStatement cst = null;

		try {
			cst = conexion.prepareCallableStatement("CALL ActualizarUsuario(?,?,?,?,?)");

			cst.setInt(1, usuario.getIdcliente());
			cst.setString(2, usuario.getNombreUsuario());
			cst.setString(3, usuario.getContrasenia());
			cst.setInt(4, usuario.getTipoUser().getIdTipoUser());
			cst.setBoolean(5, usuario.getEstado());

			int filasAfectadas = cst.executeUpdate();

			if (filasAfectadas > 0) {
				updateExitoso = true;
				cn.commit();
			} else {
				cn.rollback();
			}

		} catch (SQLException e) {
			System.err.println("Error al actualizar usuario: " + e.getMessage());
		} finally {
			try {
				if (cst != null) {
					cst.close();
				}
			} catch (SQLException e) {
				System.err.println(e.getMessage());
				e.printStackTrace();
			}
		}

		return updateExitoso;
	}

	@Override
	public boolean Insert(Usuario usuario) {
		PreparedStatement statement;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		boolean insertUsuarioExitoso = false;

		// Validar contraseña
		if (usuario.getContrasenia() == null || usuario.getContrasenia().trim().isEmpty()) {
			System.out.println("Error: La contraseña no puede ser nula o vacía");
			return false;
		}

		try {
			statement = conexion.prepareStatement(insert);
			statement.setInt(1, usuario.getIdcliente());
			statement.setString(2, usuario.getNombreUsuario());
			statement.setString(3, usuario.getContrasenia());
			statement.setInt(4, usuario.getTipoUser().getIdTipoUser());

			if (statement.executeUpdate() > 0) {
				conexion.commit();
				insertUsuarioExitoso = true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return insertUsuarioExitoso;
	}

	private Usuario getUsuario(ResultSet resultSet) throws SQLException {
		byte idTipoUser = resultSet.getByte("IdTipoUser");
		String descTipoUser = resultSet.getString("Descripcion");
		TipoUser tipoUser = new TipoUser(idTipoUser, descTipoUser);

		int idUsuario = resultSet.getInt("id");
		int idCliente = resultSet.getInt("idCliente");
		String nombreUsuario = resultSet.getString("nombreUsuario");
		String contrasenia = resultSet.getString("contrasenia");
		boolean estadoUsuario = resultSet.getBoolean("estado");
		Usuario usuario = new Usuario(idUsuario, idCliente, nombreUsuario, contrasenia, tipoUser, estadoUsuario);
		return usuario;
	}

	@Override
	public Usuario Autenticar(String username, String password) {
		Usuario user = null;
		PreparedStatement statement;
		ResultSet resultSet;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		String query = readall + " where nombreUsuario = ? and contrasenia = ? AND estado = 1";
		
		try {
			statement = conexion.prepareStatement(query);
			statement.setString(1, username);
			statement.setString(2, password);
			resultSet = statement.executeQuery();
			if (resultSet.next()) {
				user = getUsuario(resultSet);
			}
		} catch (SQLException e) {
			System.err.println("Error al leer la base de datos:");
			e.printStackTrace();
		}

		return user;
	}

	@Override
	public boolean logicalDelete(int idUsuario) {
	    Connection cn = Conexion.getConexion().getSQLConexion();
	    boolean isSuccess = false;

	    try {
	        //  OBTENER EL ID DEL CLIENTE A PARTIR DEL ID DE USUARIO
	        int idCliente = 0;
	        PreparedStatement psGetId = cn.prepareStatement(sqlGetClienteId);
	        psGetId.setInt(1, idUsuario);
	        ResultSet rs = psGetId.executeQuery();
	        if (rs.next()) {
	            idCliente = rs.getInt("id_cliente");
	        }
	        
	        if (idCliente == 0) {
	            throw new SQLException("No se encontró el cliente para el usuario ID: " + idUsuario);
	        }

	        //  DESACTIVAR LAS CUENTAS DE ESE CLIENTE
	        CuentaDao cuentaDao = new CuentaImpl(); 
	        boolean cuentasDesactivadas = cuentaDao.deactivateAccountsByClientId(idCliente);
	        
	        try (PreparedStatement stUpdateCliente = cn.prepareStatement(updateClienteSQL)) {
	            stUpdateCliente.setInt(1, idCliente);
	            stUpdateCliente.executeUpdate();
	        }


	        CallableStatement cst = cn.prepareCall("CALL EliminarLogicoUsuario(?)");
	        cst.setInt(1, idUsuario);
	        int filasUsuario = cst.executeUpdate();

	        if (filasUsuario > 0 && cuentasDesactivadas) {
	            cn.commit();
	            isSuccess = true;
	        } else {
	            throw new SQLException("La desactivación no afectó las filas esperadas, revirtiendo transacción.");
	        }

	    } catch (SQLException e) {
	        System.err.println("ERROR EN LA TRANSACCIÓN, revirtiendo cambios: " + e.getMessage());
	        try {
	            if (cn != null) cn.rollback();
	        } catch (SQLException e2) {
	            e2.printStackTrace();
	        }
	        isSuccess = false;

	    } 

	    return isSuccess;
	}

	@Override
	public boolean modificarPassword(String nuevaContrasenia, String usuario) {
		Connection conexion = Conexion.getConexion().getSQLConexion();
		PreparedStatement pst = null;
	    boolean updateExitoso = false;

	    try {
	        pst = conexion.prepareStatement(updatePassword);
	        pst.setString(1, nuevaContrasenia);
	        pst.setString(2, usuario);

	        if (pst.executeUpdate() > 0) {
	            conexion.commit();
	            updateExitoso = true;
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	        try {
	            conexion.rollback();
	        } catch (SQLException ex) {
	            ex.printStackTrace();
	        }
	    } finally {
	        try {
	            if (pst != null) pst.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }

	    return updateExitoso;
	}

	
	public boolean verificarPassword(String nombreUsuario, String contraseniaActual) {
		Connection conexion = Conexion.getConexion().getSQLConexion();
		boolean esCorrecta = false;

	    try (PreparedStatement ps = conexion.prepareStatement(readPassword)) {
	        ps.setString(1, nombreUsuario);
	        ps.setString(2, contraseniaActual);

	        ResultSet rs = ps.executeQuery();
	        
	        if (rs.next()) {
	            esCorrecta = true;
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return esCorrecta;
	}


}
