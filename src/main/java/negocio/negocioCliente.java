package negocio;

import java.util.List;

import entidad.Cliente;

public interface negocioCliente {
	public List<Cliente> ReadAll();
	public int Insert(Cliente cliente);
	public boolean update(Cliente cliente);
	public Cliente ReadOne(int idCliente);
	public Cliente getClientePorID(int id);
	public Cliente getPorIdUsuario(int idUsuario);
}
