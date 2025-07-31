package entidad;

import java.time.LocalDateTime;

public class Transferencia {
	
	private int id;
	private String numDeCuentaOrigen;
	private String numDeCuentaDestino;
	private LocalDateTime fechayHora;
	private Double saldo;
	
	
	public Transferencia(int id, String numDeCuentaOrigen, String numDeCuentaDestino, LocalDateTime fechayHora,
			Double saldo) {
		super();
		this.id = id;
		this.numDeCuentaOrigen = numDeCuentaOrigen;
		this.numDeCuentaDestino = numDeCuentaDestino;
		this.fechayHora = fechayHora;
		this.saldo = saldo;
	}
	
	public Transferencia(String numDeCuentaOrigen, String numDeCuentaDestino,
			Double saldo) {
		super();
		this.numDeCuentaOrigen = numDeCuentaOrigen;
		this.numDeCuentaDestino = numDeCuentaDestino;
		this.saldo = saldo;
	}
	
	
	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getNumDeCuentaOrigen() {
		return numDeCuentaOrigen;
	}


	public void setNumDeCuentaOrigen(String numDeCuentaOrigen) {
		this.numDeCuentaOrigen = numDeCuentaOrigen;
	}


	public String getNumDeCuentaDestino() {
		return numDeCuentaDestino;
	}


	public void setNumDeCuentaDestino(String numDeCuentaDestino) {
		this.numDeCuentaDestino = numDeCuentaDestino;
	}


	public LocalDateTime getFechayHora() {
		return fechayHora;
	}


	public void setFechayHora(LocalDateTime fechayHora) {
		this.fechayHora = fechayHora;
	}


	public Double getSaldo() {
		return saldo;
	}


	public void setSaldo(Double saldo) {
		this.saldo = saldo;
	}


	@Override
	public String toString() {
		return "Transferencia [id=" + id + ", numDeCuentaOrigen=" + numDeCuentaOrigen + ", numDeCuentaDestino="
				+ numDeCuentaDestino + ", fechayHora=" + fechayHora + ", saldo=" + saldo + "]";
	}

	
}
