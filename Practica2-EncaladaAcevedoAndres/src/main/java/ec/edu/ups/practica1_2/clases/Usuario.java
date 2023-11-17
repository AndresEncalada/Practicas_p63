package ec.edu.ups.practica1_2.clases;
public class Usuario {
	//Atributos de la clase
	private String nombre;
	private Integer edad;
	private String usuario;
	//Constructor vacio
	public Usuario() {}
	//Constructor con parametros
	public Usuario(String nombre, Integer edad, String usuario) {
		this.nombre = nombre;
		this.edad = edad;
		this.usuario = usuario;
	}
	//Getters,Setters y toString
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getNombre() {
		return nombre;
	}
	public Integer getEdad() {
		return edad;
	}
	public void setEdad(Integer edad) {
		this.edad = edad;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	@Override
	public String toString() {
		return "Usuario [nombre=" + nombre + ", edad=" + edad + ", usuario=" + usuario + "]";
	}
}
