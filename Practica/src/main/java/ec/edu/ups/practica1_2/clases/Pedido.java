package ec.edu.ups.practica1_2.clases;
import java.util.ArrayList;
import java.util.Scanner;
public class Pedido {
	//Atributos de la clase
	private ArrayList producto;
	private String nombre;
	//Constructor con parametros
	public Pedido(ArrayList producto, String nombre) {
		this.producto = producto;
		this.nombre=nombre;
	}
	//Metodo que recibe la suma de los precios
	//Luego muestra el usuario, los productos del carrito y el total a pagar
	public void realizarPedido(int total) {
		System.out.println();
		System.out.println("Usuario:"+nombre);
		System.out.println("Su pedido es:");
		System.out.println(producto);
		System.out.println();
		System.out.println("Total a pagar:"+total);
		System.out.println();
		System.out.println("Presione Enter para continuar");
		System.out.println();
		Scanner es=new Scanner(System.in);
		String entr=es.nextLine();
		
	}	
	//Getters, Setters y toString
	public ArrayList getProducto() {
		return producto;
	}
	public void setProducto(ArrayList producto) {
		this.producto = producto;
	}
	@Override
	public String toString() {
		return "Pedido [ Producto=" + producto + "]";
	}
}
