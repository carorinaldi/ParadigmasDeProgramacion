class Producto {
	const nombre
	var precioBase
	
	method iva() = 0.21
	
	method precio() {
		return precioBase + precioBase* self.iva()	
	}
	
	method nombreDeOferta() {
		return "SUPER OFERTA" + nombre 
	}	
}

class Mueble inherits Producto {
	var recargo = 1000
	
	override method precio(){
		return super() + recargo
	}
}

class Indumentaria inherits Producto {
	
}

class Ganga inherits Producto {
	
	override method precio() {
		return 0
	}
		
	override method nombreDeOferta() {
		return super() + "COMPRAME POR FAVOR" 
	}
}


const remera = new Indumentaria(nombre="Remera Lisa", precioBase=1000)