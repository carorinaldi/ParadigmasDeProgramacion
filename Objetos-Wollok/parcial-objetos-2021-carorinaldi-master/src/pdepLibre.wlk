object pdepLibre {
	var usuarios
	var productos
	
	method reducirPuntos() {
		self.usuariosMorosos().map({unUsuario => unUsuario.bajarPuntos(1000)})
	}
	
	method usuariosMorosos() {
		return usuarios.filter({unUsuario => unUsuario.esMoroso()})
	}
	
	method eliminarCuponesUtilizados() {
		usuarios.forEach{unUsuario => unUsuario.eliminarCuponesUsados()}
		
	}
	
	method obtenerNombresDeOferta() {
		return productos.map{unProducto => unProducto.nombreDeOferta()}
	}
	
	method actualizarNiveles() {
		usuarios.forEach({unUsuario => unUsuario.actualizarNivel()})
	}

}
