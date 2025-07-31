package entidad;

import java.time.LocalDate;

public class Cuota {
		
	private int idPagoDeCuota;
    private int idPrestamo;
    private short numCuota;
    private Double monto;
    private boolean estado; //1: Pagada, 0: Pendiente
    private LocalDate fechaPago;

    public Cuota() {
    }

    public Cuota(int idPagoDeCuota, int idPrestamo, short numCuota, Double monto, boolean estado, LocalDate fechaPago) {
        this.idPagoDeCuota = idPagoDeCuota;
        this.idPrestamo = idPrestamo;
        this.numCuota = numCuota;
        this.monto = monto;
        this.estado = estado;
        this.fechaPago = fechaPago;
    }

    public Cuota(int idPrestamo, short numCuota, Double monto) {
        this.idPrestamo = idPrestamo;
        this.numCuota = numCuota;
        this.monto = monto;
        this.estado = false; 
    }

    public int getIdPagoDeCuota() {
        return idPagoDeCuota;
    }

    public int getIdPrestamo() {
        return idPrestamo;
    }

    public short getNumCuota() {
        return numCuota;
    }

    public Double getMonto() {
        return monto;
    }

    public boolean isEstado() {
        return estado;
    }

    public LocalDate getFechaPago() {
        return fechaPago;
    }

    public void setIdPagoDeCuota(int idPagoDeCuota) {
        this.idPagoDeCuota = idPagoDeCuota;
    }

    public void setIdPrestamo(int idPrestamo) {
        this.idPrestamo = idPrestamo;
    }

    public void setNumCuota(short numCuota) {
        this.numCuota = numCuota;
    }

    public void setMonto(Double monto) {
        this.monto = monto;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

    public void setFechaPago(LocalDate fechaPago) {
        this.fechaPago = fechaPago;
    }

    @Override
    public String toString() {
        return "Prestamo: " + idPrestamo +
               ", numCuota=" + numCuota +
               ", monto=" + monto +
               ", estado=" + estado +
               ", fechaPago=" + fechaPago +
               '}';
    }
	
}
