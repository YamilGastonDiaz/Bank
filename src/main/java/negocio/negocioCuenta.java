package negocio;

import java.util.List;

import entidad.Cuenta;
import entidad.TipoDeCuenta;

public interface negocioCuenta {
	public boolean insert(Cuenta cuenta);
	public List<Cuenta> readAll();
	public List<Cuenta> readAll(String Condicion);
	public List<TipoDeCuenta> readAllTipoDeCuenta();
	public boolean update(Cuenta cuenta);
	public boolean actualizarTipoCuentaYEstado(Cuenta cuenta);
	boolean deactivateAccountsByClientId(int idCliente);
	List<Cuenta> readAllByClienteId(int idCliente);
	public boolean darDeBajaCuenta(String cuenta);
	public int buscarId(String dni);
	public int cantidadCuentas(String dni);
	public Cuenta obtenerCuentaPorCBU(String cbu);
}
