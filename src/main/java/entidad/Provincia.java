package entidad;

public class Provincia {
	
    private short idProvincia; 
    private String descripcion;
    
    public Provincia() {
    }

    public Provincia(Short idProvincia, String descripcion) {
        this.idProvincia = idProvincia;
        this.descripcion = descripcion;
    }
    
    public Provincia(String descripcion) {
        this.descripcion = descripcion;
    }

    public short getIdProvincia() {
        return idProvincia;
    }

    public String getDescripcion() {
        return descripcion;
    }


    public void setIdProvincia(short idProvincia) {
        this.idProvincia = idProvincia;
    }

    public void setDescripcion(String descripcion) {
            this.descripcion = descripcion;
    }

    @Override
    public String toString() {
        return idProvincia +  "-" + descripcion;
    }
	
}
