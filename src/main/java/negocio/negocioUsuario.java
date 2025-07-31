package negocio;

import java.util.List;

import entidad.Usuario;

public interface negocioUsuario {
	public boolean Insert(Usuario usuario);
	public List<Usuario> ReadAll();
	public List<Usuario> ReadAll(int estado);
	public Usuario Read(String usuario, String Pass);
	public boolean Update(Usuario usuario);
	public Usuario Autenticar(String username, String password);
	public boolean logicalDelete(int idUsuario);
	public boolean modificarPassword(String nuevaContrasenia, String usuario);
	public boolean verificarPassword(String nombreUsuario, String contraseniaActual);

}
