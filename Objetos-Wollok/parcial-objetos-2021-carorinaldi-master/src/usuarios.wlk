import niveles.*
import errores.*
import productos.*
import cupones.*

class Usuario {
	const nombre
	var dinero
	var cupones = []
	var puntos
	var nivel  // composición 
	var productosEnCarrito = []
	
	method puntos() = puntos
	
	method cupones() = cupones
	
	method agregarACarrito(unProducto){
		if (nivel.permiteAgregarProductoA(self)) {
			productosEnCarrito.add(unProducto)
		} else { 
		throw new NoPuedoAgregarProductoException()
   		}
	}
	
	method puedeTenerEnCarrito(unaCantidad) {
		return productosEnCarrito.size() <= unaCantidad
	}
	
	method comprar() {
		var valorDeLaCompra = self.aplicarCupon(self.precioTotalDelCarrito())
		self.pagar(valorDeLaCompra)
		puntos += valorDeLaCompra * 0.10
	}
	
	method precioTotalDelCarrito() {
		return productosEnCarrito.sum( {unProducto => unProducto.precio()})
	}
	
	method pagar(unaCantidad){
		dinero -= unaCantidad
	}
	method aplicarCupon(unPrecio) {
		var cuponDeCompra = self.seleccionarCupon()
		cuponDeCompra.serUsado()
		return cuponDeCompra.aplicarDescuento(unPrecio)
	}
	
	method seleccionarCupon() {
		return self.cuponesNoUsados().anyOne()
	}
	
	method cuponesNoUsados() {
    	return cupones.filter { unCupon => !unCupon.fueUsado() }
    }
    
    method esMoroso() {
    	return dinero < 0
    } 
    
    method bajarPuntos(unaCantidad) {
    	puntos -= unaCantidad 
    }
    
    method eliminarCuponesUsados(){
    	cupones.removeAllSuchThat{ unCupon => unCupon.fueUsado() }
    }
    
    method actualizarNivel() {
    	if (puntos >= 15000) nivel = oro
    	if (puntos >= 5000) nivel = plata
    	else nivel = bronce
    }
}

const caro = new Usuario(nombre="Carolina",dinero=1000,cupones=[cupon1,cupon2,cupon3],puntos=10,nivel=bronce,productosEnCarrito = [remera])