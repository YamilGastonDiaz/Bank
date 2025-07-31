package negocioImpl;

import java.util.List;

import dao.ClienteDao;
import daoImpl.ClienteImpl;
import entidad.Cliente;

import negocio.negocioCliente;


public class negocioClienteImpl implements negocioCliente {
	
	private ClienteDao clienteDao;
	
	public negocioClienteImpl() {
		clienteDao = new ClienteImpl();
	}
	
	public negocioClienteImpl(ClienteDao clienteDao) {
		this.clienteDao = clienteDao;
	}
	
	@Override
	public List<Cliente> ReadAll() {
		return clienteDao.ReadAll();
	}


	@Override
	public int Insert(Cliente cliente) {
		return clienteDao.Insert(cliente);
	}

	@Override
	public boolean update(Cliente cliente) {
		return clienteDao.update(cliente);
	}

	@Override
	public Cliente ReadOne(int idCliente) {
		return clienteDao.ReadOne(idCliente);
	}

	@Override
	public Cliente getClientePorID(int id) {
		return clienteDao.getClientePorID(id);
	}

	@Override
	public Cliente getPorIdUsuario(int idUsuario) {
		return clienteDao.getPorIdUsuario(idUsuario);
	}

	
}
