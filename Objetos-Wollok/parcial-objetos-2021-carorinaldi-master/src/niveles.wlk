import usuarios.*

object oro {
	method puedeAcceder(unUsuario) {
		return unUsuario.puntos() >= 15000
	}
	
	method permiteAgregarProductoA(unUsuario){
		return true
	}	
}

object plata {
	method puedeAcceder(unUsuario) {
		return unUsuario.puntos() >= 5000
	}

	method permiteAgregarProductoA(unUsuario){
		return unUsuario.puedeTenerEnCarrito(5)
	}	
}

object bronce {
	method puedeAcceder(unUsuario) {
		return true
	}
	
	method permiteAgregarProductoA(unUsuario){
		return unUsuario.puedeTenerEnCarrito(1)
	}
}	