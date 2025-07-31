package entidad;

import java.time.LocalDate;

public class Cuenta {
		
    private String numDeCuenta;
    private String cbu;
    private LocalDate fechaCreacion;
    private LocalDate fechaBaja;
    private TipoDeCuenta tipoDeCuenta;
    private Cliente cliente;
    private Double saldo;
    private boolean estado;
    
    public static final Double SALDO_INICIAL = 10000.00;

    public Cuenta() {
    }

    public Cuenta(String numDeCuenta, String cbu, LocalDate fechaCreacion, LocalDate fechaBaja,
    		TipoDeCuenta tipoDeCuenta, Cliente cliente, Double saldo, boolean estado) {
        this.numDeCuenta = numDeCuenta;
        this.cbu = cbu;
        this.fechaCreacion = fechaCreacion;
        this.fechaBaja = fechaBaja;
        this.tipoDeCuenta = tipoDeCuenta;
        this.cliente = cliente;
        this.saldo = saldo;
        this.estado = estado;
    }
    
    public Cuenta(String numDeCuenta, String cbu, LocalDate fechaCreacion, TipoDeCuenta tipoDeCuenta, Cliente cliente) {
        this.numDeCuenta = numDeCuenta;
        this.cbu = cbu;
        this.fechaCreacion = fechaCreacion;
        this.fechaBaja = null;
        this.tipoDeCuenta = tipoDeCuenta;
        this.cliente = cliente;
        this.saldo = SALDO_INICIAL;
        this.estado = true;
    }

    public String getNumDeCuenta() {
        return numDeCuenta;
    }

    public String getCbu() {
        return cbu;
    }

    public LocalDate getFechaCreacion() {
        return fechaCreacion;
    }

    public LocalDate getFechaBaja() {
        return fechaBaja;
    }

    public TipoDeCuenta getTipoCuenta() {
        return tipoDeCuenta;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public Double getSaldo() {
        return saldo;
    }

    public boolean Estado() {
        return estado;
    }

    public void setNumDeCuenta(String numDeCuenta) {
            this.numDeCuenta = numDeCuenta;
    }

    public void setCbu(String cbu) {
            this.cbu = cbu;
    }

    public void setFechaCreacion(LocalDate fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public void setFechaBaja(LocalDate fechaBaja) {
        this.fechaBaja = fechaBaja;
    }

    public void setTipoCuenta(TipoDeCuenta tipoDeCuenta) {
        this.tipoDeCuenta = tipoDeCuenta;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public void setSaldo(Double saldo) {
        this.saldo = saldo;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

    @Override
    public String toString() {
        return  "Cliente: " + cliente.getApellido() + "; " + cliente.getNombre() + " - Dni " + cliente.getDni() + " - Alta: " +
        		fechaCreacion + " - " + tipoDeCuenta.toString() + " - " + numDeCuenta + " - Cbu: " + cbu + " - Saldo: $" + saldo;
    }
	
}
