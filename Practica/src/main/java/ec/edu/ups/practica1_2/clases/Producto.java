package ec.edu.ups.practica1_2.clases;
public class Producto {
	//Instanciar atributos
	private String id;
	private Double precio;
	//Constructor vacio que sirve para instanciar la clase
	public Producto() {}
	//Metodo que instancia las diferentes clases de productos y las muestra en consola
	public void verProductos() {
		Literatura libro=new Literatura();
		Musica album=new Musica();
		Computacion laptop=new Computacion();
		System.out.println();
		System.out.println(libro);
		System.out.println();
		System.out.println(album);
		System.out.println();
		System.out.println(laptop);
	}
	//Constructor con parametros
	public Producto(String id, Double precio) {
		super();
		this.id = id;
		this.precio = precio;
	}
	//Getters, Setters y toString
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Double getPrecio() {
		return precio;
	}
	public void setPrecio(Double precio) {
		this.precio = precio;
	}
	@Override
	public String toString() {
		return ", id: " + id + ", Precio: $" + precio + "]";
	}
}
