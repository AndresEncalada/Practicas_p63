package ec.edu.ups.main;

import java.util.Scanner;

import ec.edu.ups.Dao.*;
import ec.edu.ups.controladores.*;
import ec.edu.ups.modelos.Libro;
import ec.edu.ups.vistas.*;

public class Principal {
	public static void main(String args[]) {
		boolean menu=true;
		//Instancia de todos los DAO's, vistas y controladores
		LibroDAO ldao=new LibroDAO();
		LibroVista lvista=new LibroVista();
		LibroControlador lcont=new LibroControlador(ldao,lvista);
		
		UsuarioDAO udao=new UsuarioDAO();
		UsuarioVista uvista=new UsuarioVista();
		UsuarioControlador uC=new UsuarioControlador(udao,uvista);
		
		PrestamoDAO pdao=new PrestamoDAO();
		PrestamoVista pvista=new PrestamoVista();
		PrestamoControlador pC=new PrestamoControlador(pdao,pvista);
		
		BibliotecaDAO bibliotecadao=new BibliotecaDAO();
		BibliotecaVista bibliotecavista=new BibliotecaVista();
		BibliotecaControlador bibliotecaC=new BibliotecaControlador(bibliotecadao,bibliotecavista);
		while(menu==true) {		
			//Muestra de las opciones del menu
			Scanner scanm1=new Scanner(System.in);
			System.out.println("|---------------------Menu----------------------|");
			System.out.println("| 1. Agregar un nuevo libro a la biblioteca     |");
			System.out.println("| 2. Registrar nuevo usuario                    |");
			System.out.println("| 3. Ver prestamos por usuario                  |");
			System.out.println("| 4. Buscar libros disponibles                  |");
			System.out.println("| 5. Prestar libro a un usuario                 |");
			System.out.println("| 6. Devolver un libro                          |");
			System.out.println("| 7. Salir                                      |");
			System.out.println("|-----------------------------------------------|");
			System.out.println();
			System.out.print("Ingrese la opcion a realizar:");
			int ent=scanm1.nextInt();
			if(ent<1||ent>6) {
				System.out.println("Opcion invalida. Presione Enter para Continuar");
				Scanner scan1=new Scanner(System.in);
				String enin=scan1.nextLine();
			}
			//Opcion para registrar el libro en la biblioteca
			if(ent==1) {
				bibliotecaC.agregarLibro(lvista.ingresarDatos());		
			}
			//Opcion para registrar el usuario en la biblioteca
			if(ent==2) {
				 bibliotecaC.agregarUsuario(uvista.ingresarDatos());
			}
			//Opcion para mostrar los prestamos del usuario
			if(ent==3) {
				//Obtiene el id del usuario
				int idU=pC.obtenerIdU();
				//Si el usuario es nulo se muestra el mensaje de error, si no
				//se muestra la lista de prestamos que posee el usuario
				if(bibliotecaC.verUsuario(idU)==null) {
					System.out.println("Usuario no encontrado");
				}
				else {
				pC.mostrarPrestamos(uC.mostrarPrestamos(bibliotecaC.verUsuario(idU)));
				}
			}
			while(ent==4) {
				//Apertura de un segundo menu 
				Scanner scanm=new Scanner(System.in);
				System.out.println("|------------------------------|");
				System.out.println("|1. Buscar por ID              |");
				System.out.println("|2. Ver todos los disponibles  |");
				System.out.println("|3. Salir                      |");
				System.out.println("|------------------------------|");
				//Se pide la opcion al usuario
				System.out.print("Ingrese la opcion a realizar:");
				int entr=scanm.nextInt();
				System.out.println();
				if(entr<1||entr>3) {
					System.out.println("Opcion invalida. Presione Enter para Continuar");
					Scanner scan1=new Scanner(System.in);
					String enin=scan1.nextLine();
				}
				//Opcion para buscar un libro por su Id
				if(entr==1) {
					int id=lcont.getId();
					Libro libro=bibliotecaC.verLibro(id);
					if(libro==null) {
						
					}
					else {
						lcont.mostrarLibro(libro);
					}
				}
				if(entr==3) {
					break;
				}
				//Opcion que muestra todos los libros que esten disponibles 
				if(entr==2) {
						lcont.mostrarLibros(bibliotecaC.verLibros());
				
				}
			}
			//Opccion para prestar un libro a un usuario
			if(ent==5) {
				//Se obtiene el id del usuario 
				int id=lcont.prestarLibro();
				//Se instancia un libro 
				Libro libro=bibliotecaC.verLibro(id);
				if(libro==null) {
					
				}
				else {
					//Si el libro esta disponible prosigue con el programa
				if(libro.isDisponible()==true) {
					//Se obtiene el id del usuario
					int idU=pC.obtenerIdU();
					if(bibliotecaC.verUsuario(idU)==null) {
					}
					else {
					//Se agrega el prestamo a la lista de prestamos que posee el usuario
					uC.agregarPrestamo(bibliotecaC.verUsuario(idU), pC.crearPrestamo(bibliotecaC.verUsuario(idU), bibliotecaC.verLibros(), id));
					bibliotecaC.prestarLibro(libro);
					}
				}
				else {
					System.out.println("Libro no disponible");
				}
				}
			}
			if(ent==6) {
				//Se repite el proceso de arriba pero en ese caso se intercambian los metodos por los de devolucion
				int id=lcont.devolverLibro();
				Libro libro=bibliotecaC.verLibro(id);
				if(libro==null) {
				}
				else {
				if(libro.isDisponible()==false) {
					int idU=pC.obtenerIdU();
					if(bibliotecaC.verUsuario(idU)==null) {
					}
					else {
					uC.eliminarPrestamo(bibliotecaC.verUsuario(idU), pC.crearPrestamo(bibliotecaC.verUsuario(idU), bibliotecaC.verLibros(), id));
					bibliotecaC.devolverLibro(libro);
					}
				}
				else {
					System.out.println("El libro no fue prestado");
				}
				}
			}
			if(ent==7) {
				break;
			}
		}
	}
}
