package negocioImpl;

import java.util.List;

import dao.UsuarioDao;
import daoImpl.UsuarioImpl;
import entidad.Usuario;
import negocio.negocioUsuario;

public class negocioUsuarioImpl implements negocioUsuario {
	
	private UsuarioDao usuarioDao;
	
	public negocioUsuarioImpl() {
		this.usuarioDao = new UsuarioImpl();
	}
	
	public negocioUsuarioImpl(UsuarioDao usuarioDao) {
		this.usuarioDao = usuarioDao;
	}

	@Override
	public boolean Insert(Usuario usuario) {
		return usuarioDao.Insert(usuario);
	}

	@Override
	public List<Usuario> ReadAll() {
		return usuarioDao.ReadAll();
	}

	@Override
	public List<Usuario> ReadAll(int estado) {
		return usuarioDao.ReadAll(estado);
	}

	@Override
	public Usuario Read(String usuario, String Pass) {
		return usuarioDao.Read(usuario, Pass);
	}

	@Override
	public boolean Update(Usuario usuario) {
		return usuarioDao.Update(usuario);
	}

	@Override
	public Usuario Autenticar(String username, String password) {
		return usuarioDao.Autenticar(username, password);
	}

	@Override
	public boolean logicalDelete(int idUsuario) {
		return usuarioDao.logicalDelete(idUsuario);
	}

	@Override
	public boolean modificarPassword(String nuevaContrasenia, String usuario) {
		return usuarioDao.modificarPassword(nuevaContrasenia, usuario);
	}

	@Override
	public boolean verificarPassword(String nombreUsuario, String contraseniaActual) {
		return usuarioDao.verificarPassword(nombreUsuario, contraseniaActual);
	}
}
