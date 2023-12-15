package ec.edu.ups.controladores;

import java.util.List;

import ec.edu.ups.Dao.BibliotecaDAO;
import ec.edu.ups.modelos.Biblioteca;
import ec.edu.ups.modelos.Libro;
import ec.edu.ups.modelos.Usuario;
import ec.edu.ups.vistas.BibliotecaVista;

public class BibliotecaControlador {
	//Atributos de la clase
	private Biblioteca biblioteca;
	private BibliotecaDAO bibliotecadao;
	private BibliotecaVista bibliotecavista;
	//Constructor con parametors
	public BibliotecaControlador(BibliotecaDAO bibliotecadao, BibliotecaVista bibliotecavista) {
		this.bibliotecadao=bibliotecadao;
		this.bibliotecavista=bibliotecavista;
	}
	//Metodo que crea la biblioteca y agrega los detalles de la biblioteca
	public void crearBiblioteca() {
		this.biblioteca=new Biblioteca("Biblioteca CCE","Calle Luis Cordero");
	}
	//Metodo que devuelve la lista de libros registrados
	public List<Libro> verLibros() {
		List<Libro> lista=bibliotecadao.verLibros();
		return lista;
	}
	//Metodo que retorna un libro segun el id de libro
	public Libro verLibro(int id) {
		if(bibliotecadao.buscarLibro(id)==null) {
			bibliotecavista.mostrarM("Libro no encontrado");
		}
		else {
			return bibliotecadao.buscarLibro(id);
		}
		return null;
	}
	//Metodo que retorna un usuario segun el id del usuario
	public Usuario verUsuario(int id) {
		if(bibliotecadao.buscarUsuario(id)==null) {
			bibliotecavista.mostrarM("Usuario no encontrado");
		}
		else {
			return bibliotecadao.buscarUsuario(id);
		}
		return null;
	}
	//Metodo que registra un libro en la biblioteca
	public void agregarLibro(Libro libro) {
		bibliotecadao.agregarLibro(libro);
	}
	//Metodo que registra un usuario en la biblioteca
	public void agregarUsuario(Usuario usuario) {
		if(bibliotecadao.buscarUsuario(usuario)==false) {
			bibliotecadao.registrarUsuario(usuario);
		}
		else {
			bibliotecavista.mostrarM("Usuario ya registrado");
		}
	}
	//Metodos que son parte del CRUD
	public void actualizarLibro(Libro libro) {
		bibliotecadao.actualizarListaLibro(libro);
	}
	public void actualizarUsuario(Usuario usuario){
		bibliotecadao.actualizarListaUsuario(usuario);
	}
	//Metodo para prestar un libro
	public void prestarLibro(Libro libro) {
		//Actualiza la disponibilidad del libro
		bibliotecadao.actualizardispLibro(libro, false);
		bibliotecavista.prestarLibro();
	}
	//Metodo para devolver un libro
	public void devolverLibro(Libro libro) {
		//Actualiza la disponibilidad del libro
		bibliotecadao.actualizardispLibro(libro, true);
		bibliotecavista.devolverLibro();
	}
}
