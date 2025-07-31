package Validacion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

import conexion.Conexion;
import excepcion.ClienteNoExisteExcepcion;
import excepcion.FechaInvalidaException;
import excepcion.SaldoInsuficienteException;

public class Validaciones {
	
	private static final String select = "select * from cuentas where num_de_cuenta like ?;";
	private static final String selectEmail = "Select 1 from clientes where correo like ?;";
	private static final String selectDNI ="Select 1 from clientes where dni like ?;";
	private static final String selectCuil ="SELECT 1 FROM cuentas WHERE cuil = ? AND estado = 1;";
	private static final String buscarNumCuenta = "select num_de_cuenta from cuentas where num_de_cuenta = ?;";
	private static final String buscarCbu = "select cbu from cuentas where cbu = ?;";
    
    public static boolean Verificarfecha(String fecha) throws FechaInvalidaException {    
        
        DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        LocalDate fechaValidar;
        if (fecha != null && !fecha.trim().isEmpty()) {
            try {
                fechaValidar = LocalDate.parse(fecha, formato);
            } catch (DateTimeParseException e) {
                return false;
            }
            LocalDate fechaMinima = LocalDate.of(1900, 1, 1);
            LocalDate fechaMaxima = LocalDate.of(2099, 12, 31);

            if (!fechaValidar.isBefore(fechaMinima) && !fechaValidar.isAfter(fechaMaxima)) {
                return true;
            }
            else
            {
            	FechaInvalidaException exc1 = new FechaInvalidaException();
                throw exc1;	
            }
        }
        return false;
        
    }
    
    public static boolean existeCuenta(String cbu) {
        
    	PreparedStatement statement = null;
    	Connection conexion = (Connection) Conexion.getConexion().getSQLConexion();
        ResultSet resultSet = null;       
        boolean cuentaExiste = false;

        try {
                      
            statement = (PreparedStatement) conexion.prepareStatement(select);
            statement.setString(1, cbu); 
            resultSet = statement.executeQuery(); 

            if (resultSet.next()) { 
                cuentaExiste = true; 
            }
            

        } catch (SQLException e) {
            System.err.println("Error SQL al buscar la cuenta" + e.getMessage());

        } catch (Exception e) {
           
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
        } finally {

            try {
                if (resultSet != null) resultSet.close();
            } catch (SQLException e) {
                System.err.println("Error al cerrar ResultSet: " + e.getMessage());
                e.printStackTrace();
            }
            try {
                if (statement != null) statement.close();
            } catch (SQLException e) {
                System.err.println("Error al cerrar PreparedStatement: " + e.getMessage());
                e.printStackTrace();
            }           
        }
        return cuentaExiste;
    }
    
    public static boolean MismaCuenta(String Cuenta1, String Cuenta2)
    {	
    	if(Cuenta1.equals(Cuenta2))
    	{
    		return true;
    	}
    	return false;
    }

public static boolean existeEmail(String email) {
        
    	PreparedStatement statement = null;
    	Connection conexion = (Connection) Conexion.getConexion().getSQLConexion();
        ResultSet resultSet = null;       
        boolean existeEmail = false;

        try {
                      
            statement = (PreparedStatement) conexion.prepareStatement(selectEmail);
            statement.setString(1, email); 
            resultSet = statement.executeQuery(); 

            if (resultSet.next()) { 
                existeEmail = true; 
            }
            

        } catch (SQLException e) {
            System.err.println("Error SQL al buscar el email " + e.getMessage());

        } catch (Exception e) {
           
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
        } finally {

            try {
                if (resultSet != null) resultSet.close();
            } catch (SQLException e) {
                System.err.println("Error al cerrar ResultSet: " + e.getMessage());
                e.printStackTrace();
            }
            try {
                if (statement != null) statement.close();
            } catch (SQLException e) {
                System.err.println("Error al cerrar PreparedStatement: " + e.getMessage());
                e.printStackTrace();
            }           
        }
        return existeEmail;
    }
    

public static boolean existeDNI(String DNI) {
    
	PreparedStatement statement = null;
	Connection conexion = (Connection) Conexion.getConexion().getSQLConexion();
    ResultSet resultSet = null;       
    boolean existeDNI = false;

    try {
                  
        statement = (PreparedStatement) conexion.prepareStatement(selectDNI);
        statement.setString(1, DNI); 
        resultSet = statement.executeQuery(); 

        if (resultSet.next()) { 
            existeDNI = true; 
        }
        

    } catch (SQLException e) {
        System.err.println("Error SQL al buscar el DNI" + e.getMessage());

    } catch (Exception e) {
       
        System.err.println("Error: " + e.getMessage());
        e.printStackTrace();
    } finally {

        try {
            if (resultSet != null) resultSet.close();
        } catch (SQLException e) {
            System.err.println("Error al cerrar ResultSet: " + e.getMessage());
            e.printStackTrace();
        }
        try {
            if (statement != null) statement.close();
        } catch (SQLException e) {
            System.err.println("Error al cerrar PreparedStatement: " + e.getMessage());
            e.printStackTrace();
        }           
    }
    return existeDNI;
}

public static boolean existeCuil(String cuil) {
	 PreparedStatement statement = null;
	    Connection conexion = Conexion.getConexion().getSQLConexion();
	    ResultSet resultSet = null;

	    boolean existeCuil = false;

	    try {
	        statement = conexion.prepareStatement(selectCuil);
	        statement.setString(1, cuil);
	        resultSet = statement.executeQuery();

	        if (resultSet.next()) {
	            existeCuil = true;
	        }
	    } catch (SQLException e) {
	        System.err.println("Error SQL al buscar el Cuil: " + e.getMessage());
	    } catch (Exception e) {
	        System.err.println("Error: " + e.getMessage());
	        e.printStackTrace();
	    } finally {
	        try {
	            if (resultSet != null) resultSet.close();
	            if (statement != null) statement.close();
	        } catch (SQLException e) {
	            System.err.println("Error al cerrar recursos: " + e.getMessage());
	            e.printStackTrace();
	        }
	    }

	    return existeCuil;
	
}
    
    public boolean buscarNumCuenta(String numCuenta) {
		PreparedStatement statement;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		boolean existe = false;
		
		try {
			statement = conexion.prepareStatement(buscarNumCuenta);
			statement.setString(1, numCuenta);
            ResultSet rs = statement.executeQuery();
            
            if (rs.next()) {
            	existe = true;
            }
			
		}catch (SQLException e) {
			e.printStackTrace();
			try {
				conexion.rollback();
			} catch (SQLException e2) {
				e2.printStackTrace();
			}
		}
		return existe;
	}
    
    public boolean buscarCbu(String cbu) {
		PreparedStatement statement;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		boolean existe = false;
		
		try {
			statement = conexion.prepareStatement(buscarCbu);
			statement.setString(1, cbu);
            ResultSet rs = statement.executeQuery();
            
            if (rs.next()) {
            	existe = true;
            }			
		}catch (SQLException e) {
			e.printStackTrace();
			try {
				conexion.rollback();
			} catch (SQLException e2) {
				e2.printStackTrace();
			}
		}
		return existe;
	}

    
    public static boolean FaltaSaldo(double saldo) throws SaldoInsuficienteException {
        if (saldo <= 0) {
            SaldoInsuficienteException exc1 = new SaldoInsuficienteException();
            throw exc1;
        }
        return false;                      
    }
    
    
    public static boolean ClienteInexistente(int id) throws ClienteNoExisteExcepcion {
        if (id == 0) {
        	ClienteNoExisteExcepcion exc1 = new ClienteNoExisteExcepcion();
            throw exc1;
        }
        return false;                      
    }
    
}
