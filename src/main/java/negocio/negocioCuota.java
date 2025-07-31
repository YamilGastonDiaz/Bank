package negocio;

import java.util.List;

import entidad.Cuota;
import entidad.Prestamo;

public interface negocioCuota {
	public boolean generarCuotas(Prestamo prestamo);
	List<Cuota> readAllByPrestamoId(int idPrestamo);
	Cuota readOne(int idCuota);
	boolean pagarCuota(int idCuota, String numCuentaOrigen);

}
