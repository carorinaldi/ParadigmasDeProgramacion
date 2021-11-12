import juegos.*
import errores.*
import usuarios.*

object gameflix {
	const juegos = []
	const usuarios = [unUsuario,otroUsuario]

	method juegos() = juegos
	method filtrar(unaCategoria) {
		return juegos.filter({ unJuego => unJuego.esDeCategoria(unaCategoria) })
	}

	method buscarJuego(nombre) {
		return juegos.findOrElse({unJuego => unJuego.seLlama(nombre)},{throw new NoExisteJuegoException(message = "no existe el juego que buscas")})
			
		}
	
	method existeJuego(nombre) {
		return juegos.contains({unJuego => unJuego.seLlama(nombre)})
	}
	
 	method cobrarSuscripciones() {
   		usuarios.forEach { unUsuario => unUsuario.pagarSuscripcion() }
  	}
	
}

