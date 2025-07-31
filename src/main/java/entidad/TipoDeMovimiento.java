package entidad;

public class TipoDeMovimiento {
		
    private short idTipoMovimiento;
    private String descripcion;

    public TipoDeMovimiento(short idTipoMovimiento, String descripcion) {
        this.idTipoMovimiento = idTipoMovimiento;
        this.descripcion = descripcion;
    }
    
    public TipoDeMovimiento(String descripcion) {
        this.descripcion = descripcion;
    }

    public TipoDeMovimiento() {
		// TODO Auto-generated constructor stub
	}

	public short getIdTipoMovimiento() {
        return idTipoMovimiento;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setIdTipoMovimiento(short idTipoMovimiento) {
        this.idTipoMovimiento = idTipoMovimiento;
    }

    public void setDescripcion(String descripcion) {
            this.descripcion = descripcion;
    }

    @Override
    public String toString() {
        return idTipoMovimiento + " - " + descripcion;
    }
	
	
}	
