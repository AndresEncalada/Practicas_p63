package ec.edu.ups.practica1_2.clases;

public class Computacion extends Producto{
	//Atributos de la clase
	private String fabricante;
	private String tipo;
	//Constructor que, al instanciar la clase, define los atributos del objeto
	public Computacion() {
		super("0102",600.0);
		this.fabricante="hp";
		this.tipo="laptop";	
	}
	//Constructor con parametros
	public Computacion(String fabricante, String tipo,String id,Double precio) {
		super(id,precio);
		this.fabricante = fabricante;
		this.tipo = tipo;
	}	
	//Getters,Setters y toString
	public String getFabricante() {
		return fabricante;
	}
	public void setFabricante(String fabricante) {
		this.fabricante = fabricante;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	@Override
	public String toString() {
		return "Computador [Fabricante: " + fabricante + ", Tipo: " + tipo+super.toString();
	}
}
