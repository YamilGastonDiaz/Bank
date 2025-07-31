package dao;

import java.util.List;

import entidad.Movimiento;
import entidad.TipoDeMovimiento;


public interface MovimientoDao {
	public List<Movimiento> ReadAll();
	public int Insert(Movimiento mov);
	public boolean update(Movimiento mov);
	Movimiento getMovimientoPorID(int id);
	TipoDeMovimiento getIDTipoMov(int tipoMov);	
	public List<Movimiento> getMovimientosPorCuenta(String cuenta);
}