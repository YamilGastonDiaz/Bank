package conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import java.sql.CallableStatement;

public class Conexion {
	
		public static Conexion instancia;
		private Connection connection;
		
		private Conexion()
		{
			try
			{
				Class.forName("com.mysql.jdbc.Driver"); 
				this.connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/Banco","root","root");
				this.connection.setAutoCommit(false);
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		
		
		public static Conexion getConexion()   
		{								
			if(instancia == null)
			{
				instancia = new Conexion();
			}
			return instancia;
		}

		public Connection getSQLConexion() 
		{
			return this.connection;
		}
		
		
		public CallableStatement prepareCallableStatement(String sql) throws SQLException
		{
			if (this.connection == null || this.connection.isClosed())
			{
				System.err.println("Error de conexión");
		        throw new SQLException("No hay una conexión válida");
		     }
		        return (CallableStatement) this.connection.prepareCall(sql);
		}


		public void cerrarConexion()
		{
			try 
			{
				this.connection.close();
			}
			catch (SQLException e) 
			{
				e.printStackTrace();
			}
			instancia = null;
		}

	
	
}
