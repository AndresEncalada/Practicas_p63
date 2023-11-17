package ec.edu.ups.practica1_2.clases;
public class Literatura extends Producto {
	//Atributos de la clase
	private String autor;
	private String genero;
	private String titulo;
	//Constructor que, al instanciar la clase, define los atributos del objeto
	public Literatura() {
		super("0401",20.0);
		this.autor="Abdon Ubidia";
		this.genero="ciencia ficcion";
		this.titulo="El palacio de los espejos";		
	}
	//Constructor con parametros
	public Literatura(String autor, String genero,String id,Double precio) {
		super(id,precio);
		this.autor = autor;
		this.genero = genero;
	}
	//Getters,Setters y toString
	public String getAutor() {
		return autor;
	}
	public void setAutor(String autor) {
		this.autor = autor;
	}
	public String getGenero() {
		return genero;
	}
	public void setGenero(String genero) {
		this.genero = genero;
	}
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	@Override
	public String toString() {
		return "Libro [Autor: " + autor + ", Genero: " + genero+super.toString();
	}
}
