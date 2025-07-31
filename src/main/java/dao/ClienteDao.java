package dao;

import java.util.List;

import entidad.Cliente;

public interface ClienteDao {
	
	public List<Cliente> ReadAll();
	public int Insert(Cliente cliente);
	public boolean update(Cliente cliente);
	public Cliente getClientePorID(int id);
	public Cliente ReadOne(int idCliente);
	public Cliente getPorIdUsuario(int idUsuario);
}
