package excepcion;

public class ClienteNoExisteExcepcion extends Exception{
		
	private static final long serialVersionUID = 1L;

	public ClienteNoExisteExcepcion() {
		
	}

	@Override
	public String getMessage() {
		return "No se puede crear la cuenta, porque el cliente es inexistente.";
	}
	
}
