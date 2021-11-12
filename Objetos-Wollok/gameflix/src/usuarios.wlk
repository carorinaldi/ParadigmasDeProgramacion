import suscripciones.*
import juegos.*
import errores.*

class Usuario {
	var suscripcion
	var dinero
	var humor
	
	method actualizarSuscripcion(nuevaSuscripcion) {
		suscripcion = nuevaSuscripcion
	}
	
	method pagarSuscripcion(){
		if (self.puedePagarSuscripcion()) { dinero -= suscripcion.costo()}
		else self.actualizarSuscripcion(prueba)
		}
	
	method puedePagarSuscripcion() {
		return suscripcion.costo() < dinero
	}
	
	method reduceHumor(unaCantidad) {
		humor -= unaCantidad
	}

	method aumentaHumor(unaCantidad) {
		humor += unaCantidad
	}
	
	method comprarSkins(){
		dinero -= 30
	}
	
	method tirarTodoAlCarajo() {
		self.actualizarSuscripcion(infantil)
	}

  	method jugar(unJuego, unasHoras) {
    	if (suscripcion.permiteJugar(unJuego)) {
      		unJuego.serJugado(self, unasHoras)
    	} else {
      		throw new NoPuedoJugarException()
    	}
  	}
  	method gastar(unaCantidad) {
    	if(self.puedePagar(unaCantidad)){
      		dinero -= unaCantidad
    	} else {
      		throw new NoMeAlcanzaLaPlataException()
    	}
  	}
   	
   	 method puedePagar(unaCantidad) {
    	return dinero >= unaCantidad
 	 }
}


const unUsuario = new Usuario(suscripcion = premium, dinero=1000, humor=100)
const otroUsuario = new Usuario(suscripcion = premium, dinero=10, humor=200)