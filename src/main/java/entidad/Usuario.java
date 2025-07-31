package entidad;

public class Usuario {
		
	private int idUsuario;
	private int idcliente;
    private String nombreUsuario;
    private String contrasenia;
    private TipoUser tipoUser;
    private boolean estado;

    public Usuario() {
    }

    public Usuario(int idUsuario, int idCliente, String nombreUsuario, String contrasenia, TipoUser tipoUser, boolean estado) {
        this.idUsuario = idUsuario;
        this.idcliente = idCliente;
        this.nombreUsuario = nombreUsuario;
        this.contrasenia = contrasenia;
        this.tipoUser = tipoUser;
        this.estado = estado;
    }

    public Usuario(int idCliente, String nombreUsuario, String contrasenia, TipoUser tipoUser) {
    	this.idcliente = idCliente;
        this.nombreUsuario = nombreUsuario;
        this.contrasenia = contrasenia;
        this.tipoUser = tipoUser;
        this.estado = true;
    }

    public int getIdUsuario() {
        return idUsuario;
    }


    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public String getContrasenia() {
        return contrasenia;
    }

    public TipoUser getTipoUser() {
        return tipoUser;
    }

    public boolean getEstado() {
        return estado;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }


    public void setNombreUsuario(String nombreUsuario) {
            this.nombreUsuario = nombreUsuario;
    }

    public void setContrasenia(String contrasenia) {
            this.contrasenia = contrasenia;
    }

    public void setTipoUser(TipoUser tipoUser) {
        this.tipoUser = tipoUser;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }


	public int getIdcliente() {
		return idcliente;
	}

	public void setIdcliente(int idcliente) {
		this.idcliente = idcliente;
	}

	@Override
	public String toString() {
		return "Usuario [idUsuario=" + idUsuario + ", idcliente=" + idcliente + ", nombreUsuario=" + nombreUsuario
				+ ", contrasenia=" + contrasenia + ", tipoUser=" + tipoUser + ", estado=" + estado + "]";
	}
	
	
	
	
}
