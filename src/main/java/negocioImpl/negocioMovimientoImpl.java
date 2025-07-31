package negocioImpl;

import java.util.List;

import dao.MovimientoDao;
import daoImpl.MovimientoImpl;
import entidad.Movimiento;
import entidad.TipoDeMovimiento;
import negocio.negocioMovimiento;

public class negocioMovimientoImpl implements negocioMovimiento {
	
	private MovimientoDao movimientoDao;
	
	public negocioMovimientoImpl()
	{
		movimientoDao = new MovimientoImpl();
	}
	
	public negocioMovimientoImpl(MovimientoDao movimientoDao)
	{
		this.movimientoDao = movimientoDao;
	}

	@Override
	public List<Movimiento> ReadAll() {
		return movimientoDao.ReadAll();
	}

	@Override
	public int Insert(Movimiento mov) {
		return movimientoDao.Insert(mov);
	}

	@Override
	public boolean update(Movimiento mov) {
		return movimientoDao.update(mov);
	}

	@Override
	public Movimiento getMovimientoPorID(int id) {
		return movimientoDao.getMovimientoPorID(id);
	}

	@Override
	public TipoDeMovimiento getIDTipoMov(int tipoMov) {
		return movimientoDao.getIDTipoMov(tipoMov);
	}

	@Override
	public List<Movimiento> getMovimientosPorCuenta(String cuenta) {
		return movimientoDao.getMovimientosPorCuenta(cuenta);
	}
	
}
