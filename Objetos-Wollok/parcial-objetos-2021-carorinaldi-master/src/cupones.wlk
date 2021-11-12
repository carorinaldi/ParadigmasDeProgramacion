import usuarios.*


class Cupon {
	var fueUsado = false
	const descuento

	/*Los usuarios tienen cupones de uso único que se aplican al realizar compras.*/
	// method aplicarCupon()	
	method fueUsado() {
		return fueUsado
	}

	method serUsado() {
		if (!fueUsado)
			fueUsado = true
	}
	
	method aplicarDescuento(unPrecio) {
		return unPrecio - unPrecio * descuento
	}
	
}


const cupon1 = new Cupon(descuento = 0.05)
const cupon2 = new Cupon(descuento = 0.10)
const cupon3 = new Cupon(descuento = 0.20)