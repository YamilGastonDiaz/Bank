package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conexion.Conexion;
import dao.ProvinciaDao;
import entidad.Provincia;

public class ProvinciaImp implements ProvinciaDao{
	private static final String readall = "Select id_provincia, descripcion FROM provincias";

	@Override
	public List<Provincia> readAll() {
		PreparedStatement statement;
		ResultSet result;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		ArrayList<Provincia> provinciaList = new ArrayList<Provincia>();
		
		
		try {
			statement = conexion.prepareStatement(readall);
			result = statement.executeQuery();
			
			while(result.next()) {
				provinciaList.add(getProvincia(result));
			}
		} catch(SQLException e) {
			System.out.println("Error al leer provincias:");
	        e.printStackTrace();
		}
		return provinciaList;
	}

	private Provincia getProvincia(ResultSet resultSet) throws SQLException{
		short id_provincia = resultSet.getShort("id_provincia");
		String descripcion = resultSet.getString("descripcion");
		return new Provincia(id_provincia, descripcion);
	}
}
