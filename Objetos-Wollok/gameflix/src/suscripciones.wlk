import juegos.*

object premium {
	var costo = 50

	method costo() = costo

	method permiteJugar(unJuego) {
		return true
	}
}

object base {
	var costo = 25

	method costo() = costo

	method permiteJugar(unJuego) {
		return unJuego.esBarato()
	}
}

class SuscripcionCategorica {
	const categoria
	const costo
	
	method costo() = costo
	method permiteJugar(unJuego) {
		return unJuego.esDeCategoria(categoria)
	}
}

const prueba = new SuscripcionCategorica(categoria = "Demo", costo = 0)
const infantil = new SuscripcionCategorica(categoria = "Infantil", costo = 10)
