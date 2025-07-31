package dao;

import java.util.List;

import entidad.Cuenta;
import entidad.TipoDeCuenta;

public interface CuentaDao {
	public boolean insert(Cuenta cuenta);
	public int buscarId(String dni);
	public int cantidadCuentas(String dni);
	public boolean darDeBajaCuenta(String cuenta);
	public List<Cuenta> readAll();
	public List<Cuenta> readAll(String Condicion);
	public List<TipoDeCuenta> readAllTipoDeCuenta();
	public Cuenta obtenerCuentaPorNumero(String nroCuenta);
	public boolean update(Cuenta cuenta);
	public boolean actualizarTipoCuentaYEstado(Cuenta cuenta);
	public Cuenta obtenerCuentaPorCBU(String cbu);


	boolean deactivateAccountsByClientId(int idCliente);
	List<Cuenta> readAllByClienteId(int idCliente);
	

}
