package entidad;

public class Localidad {
	
	private short idLocalidad;   
    private String descripcion;  
    private Provincia provincia;   

    public Localidad() {}
   
	public Localidad(short id, String descripcion2) {
		this.idLocalidad = id;
	    this.descripcion = descripcion2;
	}

	public Localidad(short idLocalidad, String descripcion, Provincia provincia) {
        this.idLocalidad = idLocalidad;
        this.descripcion = descripcion;
        this.provincia = provincia;
    }

	public Localidad(String descripcion) {
		this.descripcion = descripcion;
	}

	public Localidad(String descripcion, Provincia provincia) {
        this.descripcion = descripcion;
        this.provincia = provincia;
    }

    
    

	public short getIdLocalidad() {
        return idLocalidad;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public Provincia getProvincia() {
        return provincia;
    }

    public void setIdLocalidad(short idLocalidad) {
        this.idLocalidad = idLocalidad;
    }

    public void setDescripcion(String descripcion) {
            this.descripcion = descripcion;
    }


    public void setProvincia(Provincia provincia) {
        this.provincia = provincia;
    }


    public String toString() {
        return idLocalidad + "-" + descripcion;
    }
	
}
