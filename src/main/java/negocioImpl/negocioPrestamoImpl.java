package negocioImpl;

import java.util.List;

import dao.PrestamoDao;
import daoImpl.PrestamoImpl;
import entidad.Prestamo;
import negocio.negocioPrestamo;

public class negocioPrestamoImpl implements negocioPrestamo {
	
	private PrestamoDao prestamoDao;

	public negocioPrestamoImpl() {
		this.prestamoDao = new PrestamoImpl();
	}
	
	public negocioPrestamoImpl(PrestamoDao prestamoDao) {
		this.prestamoDao = prestamoDao;
	}

	@Override
	public boolean insert(Prestamo prestamo) {
		return prestamoDao.insert(prestamo);
	}

	@Override
	public List<Prestamo> readAll() {
		return prestamoDao.readAll();
	}

	@Override
	public List<Prestamo> readAllByClienteId(int idCliente) {
		return prestamoDao.readAllByClienteId(idCliente);
	}

	@Override
	public Prestamo readById(int idPrestamo) {
		return prestamoDao.readById(idPrestamo);
	}
	
}
