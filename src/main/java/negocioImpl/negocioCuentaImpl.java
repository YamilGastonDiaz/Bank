package negocioImpl;

import java.util.List;

import dao.CuentaDao;
import daoImpl.CuentaImpl;
import entidad.Cuenta;
import entidad.TipoDeCuenta;
import negocio.negocioCuenta;


public class negocioCuentaImpl implements negocioCuenta{
	
	private CuentaDao cuentaDao; 
	
	public negocioCuentaImpl() {
		cuentaDao = new CuentaImpl();
	}
	
	public negocioCuentaImpl(CuentaDao cuentaDao) {
		this.cuentaDao = cuentaDao;
	}

	@Override
	public boolean insert(Cuenta cuenta) {
		return cuentaDao.insert(cuenta);
	}

	@Override
	public List<Cuenta> readAll() {
		return cuentaDao.readAll();
	}

	@Override
	public List<Cuenta> readAll(String Condicion) {
		return cuentaDao.readAll(Condicion);
	}

	@Override
	public List<TipoDeCuenta> readAllTipoDeCuenta() {
		return cuentaDao.readAllTipoDeCuenta();
	}

	@Override
	public boolean update(Cuenta cuenta) {
		return cuentaDao.update(cuenta);
	}

	@Override
	public boolean actualizarTipoCuentaYEstado(Cuenta cuenta) {
		return cuentaDao.actualizarTipoCuentaYEstado(cuenta);
	}

	@Override
	public boolean deactivateAccountsByClientId(int idCliente) {
		return cuentaDao.deactivateAccountsByClientId(idCliente);
	}

	@Override
	public List<Cuenta> readAllByClienteId(int idCliente) {
		return cuentaDao.readAllByClienteId(idCliente);
	}

	@Override
	public boolean darDeBajaCuenta(String cuenta) {
		return cuentaDao.darDeBajaCuenta(cuenta);
	}

	@Override
	public int buscarId(String dni) {
		return cuentaDao.buscarId(dni);
	}

	@Override
	public int cantidadCuentas(String dni) {
		return cuentaDao.cantidadCuentas(dni);
	}

	@Override
	public Cuenta obtenerCuentaPorCBU(String cbu) {
		return cuentaDao.obtenerCuentaPorCBU(cbu);
	}

}
