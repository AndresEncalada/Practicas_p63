package ec.edu.ups.practica1_2.clases;
import java.util.ArrayList;
public class Carrito {
	//Instanciar Atributos tipo ArrayList
	ArrayList<String> nombreU=new ArrayList<String>();
	ArrayList<ArrayList<String>> carritos=new ArrayList<ArrayList<String>>();
	ArrayList<String> carritovacio=new ArrayList<String>();
	ArrayList<Integer> totallista=new ArrayList<Integer>();
	//Constructor que añade la palabra "Carrito vacio" al ArrayList carritovacio 
	//Ademas agrega un total a pagar de 0 por cada usuario registrado
	public Carrito() {
		carritovacio.add("Carrito vacio");
		totallista.add(0);
	}
	//Este metodo va sumando un total en la posicion asiganada al usuario
	public void asignarTotal(int user, int total) {
		totallista.set(user,totallista.get(user)+total);
	}
	//Metodo que recibe el usuario para buscarlo en el ArrayList de usuarios, luego retorna un booleano 
	//Metodo que comprueba que el usuario recibido se encuentre em el ArrayList de Usuarios registrados
	public int getTotal(int user) {
		int total=totallista.get(user);
		return total;
	}
	public boolean comprobarUsuario(String usuario){
		boolean v=false;
		for(int i=0;i<(nombreU.size());i++) {
			if(usuario.equals(nombreU.get(i))) {
				v=true;
					
			}
		}
		return v;
	}
	//Metodo que recibe el usuario para buscarlo en el ArrayList de usuarios, luego retorna un Integer
	public int buscarUsuario(String usuario) {
		int n=-1;
		for(int i=0;i<(nombreU.size());i++) {
			if(usuario.equals(nombreU.get(i))) {
				n=i;
			}
		}
		return n;
	}
	//Metodo que recibe un valor, el cual lo usa para obtener y retornar el nombre en esa posicion
	public String mostrarUsuario(int n) {
		return nombreU.get(n);
	}
	//Metodo que agrega el producto recibido a la posicion en la que se encuentra el usuario que esta navegando actualmente
	public void agregarProducto(ArrayList<String> producto, int user) {	
		this.carritos.set(user, producto); 	
			
	}
	//Metodo que muestra todos los nombres registrados en el ArrayList
	public ArrayList<String> getNombreU() {
		for(int i=0;i<(nombreU.size()-1);i++) {
			System.out.println(nombreU.get(i));
		}
		return nombreU;
	}
	//Metodo que agrega el nombre del usuario registrado al ArrayList de usuarios
	//Ademas agrega el mensaje "Carrito vacio" al ArrayList de carritos
	public void setNombreU(String nombre) {
		this.nombreU.add(nombre);
		this.carritos.add(carritovacio);
	}
	//Metodo que muestra el carrito segun la posicion del usuario
	public ArrayList getCarrito(int user) {
		return carritos.get(user);
	}
	//Metodo toString
	@Override
	public String toString() {
		return "Carrito [nombre=" + nombreU + "Carritos registrados:"+carritos+"]";
	}
}
