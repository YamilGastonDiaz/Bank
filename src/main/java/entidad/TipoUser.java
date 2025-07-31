package entidad;

public class TipoUser {
	
    private byte idTipoUser;    
    private String descripcion; 

    public TipoUser() {
    }

    public TipoUser(byte idTipoUser, String descripcion) {
        this.idTipoUser = idTipoUser;
        this.descripcion = descripcion;
    }


    public TipoUser(String descripcion) {
        this.descripcion = descripcion;
    }

    public byte getIdTipoUser() {
        return idTipoUser;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setIdTipoUser(byte idTipoUser) {
        this.idTipoUser = idTipoUser;
    }

    public void setDescripcion(String descripcion) {
            this.descripcion = descripcion;
        }


    public String toString() {
        return idTipoUser + "-" + descripcion ;
    }

}
