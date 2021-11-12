class Juego {
	const nombre
	var precio
	var categoria
	
	method esDeCategoria(unaCategoria) {
		return categoria == unaCategoria
	}
	
	method seLlama(unNombre) {
		return nombre == unNombre
	}	
	
	method esBarato() {
		return precio < 30
	}	
}
	
class JuegoViolento inherits Juego {
	method serJugado(unUsuario,unasHoras) {
		unUsuario.reduceHumor(10 * unasHoras)
	}
}

class MOBA inherits Juego {
	method serJugado(unUsuario,unasHoras) {
		unUsuario.comprarSkins()
	}
}

class Terror inherits Juego {
	method serJugado(unUsuario,unasHoras) {
		unUsuario.tirarTodoAlCarajo()
	}
}

class Estrategico inherits Juego {
	method serJugado(unUsuario,unasHoras) {
		unUsuario.aumentaHumor(5 * unasHoras)
	}
}
