package entidad;

import java.time.LocalDate;
import java.util.Objects;


public class Cliente {
	
	private int idCliente;
    private String dni;
    private String cuil;
    private String nombre;
    private String apellido;
    private char sexo; 
    private String nacionalidad;
    private LocalDate fechaNacimiento; 
    private String direccion;
    private Localidad localidad;
    private String correo;
    private String telefono;
    private Usuario user; 
    private LocalDate fechaAlta; 
    private boolean estado;
    private boolean tienePrestamoActivo;

    
    public Cliente() {
	}

    
    public Cliente(int idCliente, String dni, String cuil, String nombre, String apellido, char sexo,
                   String nacionalidad, LocalDate fechaNacimiento, String direccion, Localidad localidad,
                   String correo, String telefono,Usuario user, LocalDate fechaAlta, boolean estado) {
        this.idCliente = idCliente;
        this.dni = dni;
        this.cuil = cuil;
        this.nombre = nombre;
        this.apellido = apellido;
        this.sexo = sexo;
        this.nacionalidad = nacionalidad;
        this.fechaNacimiento = fechaNacimiento;
        this.direccion = direccion;
        this.localidad = localidad;
        this.correo = correo;
        this.telefono = telefono;
        this.user = user;
        this.fechaAlta = fechaAlta;
        this.estado = estado;
    }

    public Cliente(String dni, String cuil, String nombre, String apellido, char sexo,
            String nacionalidad, LocalDate fechaNacimiento, String direccion, Localidad localidad,
            String correo, String telefono,Usuario user) {
    	this.dni = dni;
    	this.cuil = cuil;
    	this.nombre = nombre;
    	this.apellido = apellido;
    	this.sexo = sexo;
    	this.nacionalidad = nacionalidad;
    	this.fechaNacimiento = fechaNacimiento;
    	this.direccion = direccion;
    	this.localidad = localidad;
    	this.correo = correo;
    	this.telefono = telefono;
    	this.user = user;
    }

    public boolean isTienePrestamoActivo() {
        return tienePrestamoActivo;
    }

    public void setTienePrestamoActivo(boolean tienePrestamoActivo) {
        this.tienePrestamoActivo = tienePrestamoActivo;
    }
    
    public int getIdCliente() {
        return idCliente;
    }

    public String getDni() {
        return dni;
    }

    public String getCuil() {
        return cuil;
    }

    public String getNombre() {
        return nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public char getSexo() {
        return sexo;
    }

    public String getNacionalidad() {
        return nacionalidad;
    }

    public LocalDate getFechaNacimiento() {
        return fechaNacimiento;
    }

    public String getDireccion() {
        return direccion;
    }

    public Localidad getLocalidad() {
        return localidad;
    }

    public String getCorreo() {
        return correo;
    }

    public String getTelefono() {
        return telefono;
    }
    
    public Usuario getUser() {
        return user;
    }

    public LocalDate getFechaAlta() {
        return fechaAlta;
    }

    public boolean Estado() {
        return estado;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public void setDni(String dni) {
            this.dni = dni;
    }

    public void setCuil(String cuil) {
            this.cuil = cuil;
    }

    public void setNombre(String nombre) {
            this.nombre = nombre;
    }

    public void setApellido(String apellido) {
            this.apellido = apellido;
    }

    public void setSexo(char sexo) {
            this.sexo = sexo;
    }

    public void setNacionalidad(String nacionalidad) {
            this.nacionalidad = nacionalidad;
    }

    public void setFechaNacimiento(LocalDate fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public void setDireccion(String direccion) {
            this.direccion = direccion;
    }

    public void setLocalidad(Localidad localidad) {
        this.localidad = localidad;
    }

    public void setCorreo(String correo) {
            this.correo = correo;
    }

    public void setTelefono(String telefono) {
            this.telefono = telefono;
    }
    
    public void setUser (Usuario user) {
		this.user = user;
	}

    public void setFechaAlta(LocalDate fechaAlta) {
        this.fechaAlta = fechaAlta;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }
    
    public boolean equals(Object c) {
        if (this == c) return true; 
        if (c == null || getClass() != c.getClass()) return false; 
        Cliente cliente = (Cliente) c; 
        return idCliente == cliente.idCliente && Objects.equals(dni, cliente.dni);
    }
  
    @Override
    public int hashCode() {        
        return Objects.hash(idCliente, dni);
    }

    @Override
    public String toString() {
        return "Cliente{" +
               "idCliente=" + idCliente +
               ", dni='" + dni + '\'' +
               ", cuil='" + cuil + '\'' +
               ", nombre='" + nombre + '\'' +
               ", apellido='" + apellido + '\'' +
               ", sexo='" + sexo + '\'' +
               ", nacionalidad='" + nacionalidad + '\'' +
               ", fechaNacimiento=" + fechaNacimiento +
               ", direccion='" + direccion + '\'' +
               ", idLocalidad=" + localidad +
               ", correo='" + correo + '\'' +
               ", telefono='" + telefono + '\'' +
               ", User='" + user + '\'' +
               ", fechaAlta=" + fechaAlta +
               ", estado=" + estado +
               '}';
    }
	
	
}
