package daoImpl;

import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;

import conexion.Conexion;
import dao.TransferenciaDao;
import entidad.Transferencia;

public class TransferenciaImpl implements TransferenciaDao{
	
	private final String insert =  "call RealizarTransferencia(?, ?, ?, ?, ?);";

	@Override
	public boolean Insert(Transferencia transferencia, String detalle) {
		

		PreparedStatement statement;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		boolean insertExitoso = false;
		
		try {
			statement = conexion.prepareStatement(insert);
			statement.setString(1, transferencia.getNumDeCuentaOrigen());
			statement.setString(2, transferencia.getNumDeCuentaDestino());
			statement.setDouble(3, transferencia.getSaldo());
			
			LocalDateTime fecha = LocalDateTime.now();
			statement.setTimestamp(4, Timestamp.valueOf(fecha));
			
			statement.setString(5, detalle);
			
			
			statement.execute();
			conexion.commit();
			insertExitoso = true;
			
			
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

}
