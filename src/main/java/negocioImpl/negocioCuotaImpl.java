package negocioImpl;

import java.util.List;

import dao.CuotaDao;
import daoImpl.CuotaImpl;
import entidad.Cuota;
import entidad.Prestamo;
import negocio.negocioCuota;

public class negocioCuotaImpl implements negocioCuota{

	private CuotaDao cuotaDao;	
	
	public negocioCuotaImpl() {
		this.cuotaDao = new CuotaImpl();
	}
	
	public negocioCuotaImpl(CuotaDao cuotaDao) {
		this.cuotaDao = cuotaDao;
	}

	@Override
	public boolean generarCuotas(Prestamo prestamo) {
		return cuotaDao.generarCuotas(prestamo);
	}

	@Override
	public List<Cuota> readAllByPrestamoId(int idPrestamo) {
		return cuotaDao.readAllByPrestamoId(idPrestamo);
	}

	@Override
	public Cuota readOne(int idCuota) {
		return cuotaDao.readOne(idCuota);
	}

	@Override
	public boolean pagarCuota(int idCuota, String numCuentaOrigen) {
		return cuotaDao.pagarCuota(idCuota, numCuentaOrigen);
	}

}
