package excepcion;

public class FechaInvalidaException extends Exception{

	private static final long serialVersionUID = 1L;

	public FechaInvalidaException() {
		super();
	}

	@Override
	public String getMessage() {
		// TODO Auto-generated method stub
		return "La fecha es invalida, rango fuera del 01/01/1900 al 31/12/2099";
	}
	
	
	

}
