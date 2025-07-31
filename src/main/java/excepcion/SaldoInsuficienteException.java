package excepcion;

public class SaldoInsuficienteException extends Exception{

	private static final long serialVersionUID = 1L;

	public SaldoInsuficienteException() {
		super();
	}

	public String getMessage() {
		return "no se puede realizar la transferencia, saldo insuficiente";
	}
	
}
