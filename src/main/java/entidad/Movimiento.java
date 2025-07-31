package entidad;

import java.time.LocalDate;

public class Movimiento {
	 	private int idMovimiento;
	    private LocalDate fecha;
	    private String detalle;
	    private Double importe;
	    private TipoDeMovimiento tipoMovimiento; 
	    private String numDeCuenta; 
	    
	    public Movimiento() {}

	    public Movimiento(int idMovimiento, LocalDate fecha, String detalle, Double importe,
	    		TipoDeMovimiento tipoMovimiento, String numDeCuenta) {
	        this.idMovimiento = idMovimiento;
	        this.fecha = fecha;
	        this.detalle = detalle;
	        this.importe = importe;
	        this.tipoMovimiento = tipoMovimiento;
	        this.numDeCuenta = numDeCuenta;
	    }

	    public Movimiento(String detalle, Double importe, TipoDeMovimiento tipoMovimiento, String numDeCuenta) {
	        this.fecha = LocalDate.now(); 
	        this.detalle = detalle;
	        this.importe = importe;
	        this.tipoMovimiento = tipoMovimiento;
	        this.numDeCuenta = numDeCuenta;
	    }

	    public Movimiento(int id, String detalle2) {
	    	this.idMovimiento = id;
	    	this.detalle = detalle2;
		}

		public int getIdMovimiento() {
	        return idMovimiento;
	    }

	    public LocalDate getFecha() {
	        return fecha;
	    }

	    public String getDetalle() {
	        return detalle;
	    }

	    public Double getImporte() {
	        return importe;
	    }

	    public TipoDeMovimiento getTipoMovimiento() {
	        return tipoMovimiento;
	    }

	    public String getNumDeCuenta() {
	        return numDeCuenta;
	    }

	    public void setIdMovimiento(int idMovimiento) {
	        this.idMovimiento = idMovimiento;
	    }

	    public void setFecha(LocalDate fecha) {
	        this.fecha = fecha;
	    }

	    public void setDetalle(String detalle) {
	        if (detalle != null && detalle.length() > 50) {
	            this.detalle = detalle.substring(0, 50);
	        } else {
	            this.detalle = detalle;
	        }
	    }

	    public void setImporte(Double importe) {
	        this.importe = importe;
	    }

	    public void setIdTipoMovimiento(TipoDeMovimiento tipoMovimiento) {
	        this.tipoMovimiento = tipoMovimiento;
	    }

	    public void setNumDeCuenta(String numDeCuenta) {
	            this.numDeCuenta = numDeCuenta;
	    }

	    @Override
	    public String toString() {
	        return "Movimiento{" +
	               "idMovimiento=" + idMovimiento +
	               ", fecha=" + fecha +
	               ", detalle='" + detalle + '\'' +
	               ", importe=" + importe +
	               ", idTipoMovimiento=" + tipoMovimiento +
	               ", numDeCuenta='" + numDeCuenta + '\'' +
	               '}';
	    }
}
