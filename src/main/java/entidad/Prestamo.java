package entidad;

import java.time.LocalDate;

public class Prestamo {
	
	private int idPrestamo;
    private String numDeCuenta;
    private String nombreUsuario;
    private LocalDate fecha;
    private Double importePedido;
    private short cuotas;
    private Double importeMensual;
    private boolean estado;    // 0: Pendiente, 1: Respondido
    private boolean aprobado;  // 0: Rechazado, 1: Activo
    private boolean finalizado; // 0: No finalizado, 1: Finalizado
    private int cuotasPagadas;

    public Prestamo() {
    }

    public Prestamo(int idPrestamo, String numDeCuenta, String nombreUsuario, LocalDate fecha, Double importePedido, short cuotas, Double importeMensual, boolean estado, boolean aprobado, boolean finalizado) {
        this.idPrestamo = idPrestamo;
        this.numDeCuenta = numDeCuenta;
        this.nombreUsuario = nombreUsuario;
        this.fecha = fecha;
        this.importePedido = importePedido;
        this.cuotas = cuotas;
        this.importeMensual = importeMensual;
        this.estado = estado;
        this.aprobado = aprobado;
        this.finalizado = finalizado;
    }

    public Prestamo(String numDeCuenta, Double importePedido, short cuotas, Double importeMensual) {
        this.numDeCuenta = numDeCuenta;
        this.fecha = LocalDate.now(); 
        this.importePedido = importePedido;
        this.cuotas = cuotas;
        this.importeMensual = importeMensual;
        this.estado = false;   // Default 0: Pendiente
        this.aprobado = false; // Default 0: Rechazado
        this.finalizado = false; // Default 0: No finalizado
    }

    public int getIdPrestamo() {
        return idPrestamo;
    }

    public String getNumDeCuenta() {
        return numDeCuenta;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public Double getImportePedido() {
        return importePedido;
    }

    public short getCuotas() {
        return cuotas;
    }

    public Double getImporteMensual() {
        return importeMensual;
    }

    public boolean isEstado() {
        return estado;
    }

    public boolean isAprobado() {
        return aprobado;
    }

    public boolean isFinalizado() {
        return finalizado;
    }

    public void setIdPrestamo(int idPrestamo) {
        this.idPrestamo = idPrestamo;
    }

    public void setNumDeCuenta(String numDeCuenta) {
            this.numDeCuenta = numDeCuenta;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public void setImportePedido(Double importePedido) {
        this.importePedido = importePedido;
    }

    public void setCuotas(short cuotas) {
        this.cuotas = cuotas;
    }

    public void setImporteMensual(Double importeMensual) {
        this.importeMensual = importeMensual;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

    public void setAprobado(boolean aprobado) {
        this.aprobado = aprobado;
    }

    public void setFinalizado(boolean finalizado) {
        this.finalizado = finalizado;
    }
    
    public int getCuotasPagadas() {
        return cuotasPagadas;
    }

    public void setCuotasPagadas(int cuotasPagadas) {
        this.cuotasPagadas = cuotasPagadas;
    }

    @Override
    public String toString() {
        return "Prestamo{" +
               "idPrestamo=" + idPrestamo +
               ", numDeCuenta='" + numDeCuenta + '\'' +
               ", nombreUsuario='" + nombreUsuario + '\'' +  // <-- agregado
               ", fecha=" + fecha +
               ", importePedido=" + importePedido +
               ", cuotas=" + cuotas +
               ", importeMensual=" + importeMensual +
               ", estado=" + estado +
               ", aprobado=" + aprobado +
               ", finalizado=" + finalizado +
               '}';
    }

	public String getNombreUsuario() {
		return nombreUsuario;
	}

	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}
	
}
