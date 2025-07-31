package entidad;

public class TipoDeCuenta {
		
	
    private short idTipoCuenta;
    private String descripcion;

    public TipoDeCuenta() {
    }

    public TipoDeCuenta(short idTipoCuenta, String descripcion) {
        this.idTipoCuenta = idTipoCuenta;
        this.descripcion = descripcion;
    }

    public TipoDeCuenta(String descripcion) {
        this.descripcion = descripcion;
    }

    public short getIdTipoCuenta() {
        return idTipoCuenta;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setIdTipoCuenta(short idTipoCuenta) {
        this.idTipoCuenta = idTipoCuenta;
    }

    public void setDescripcion(String descripcion) {
            this.descripcion = descripcion;
    }

    @Override
    public String toString() {
        return  idTipoCuenta + " - " + descripcion;
    }
}
