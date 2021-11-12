import extras.*

class Simulador {
	const nombre
	var edad
	var dinero


//cuando un integrante es registrado (sin importar el tipo) recibe un primer pago 
//igual al que les corresponde por cada operativo	
	method initialize() {
		self.cobrar()
	}
	
//Cada vez que un integrante termina un operativo cobra cierta cantidad de dinero
	method cobrar() {
		dinero += self.cuantoCobra()
	}
	
	method cuantoCobra() {
		return 5000
	}
	
	method puedeSimular()
	 
}

class Planificador inherits Simulador {
	var requisitos = ["código penal", "biografías de pintores", "muebles de pino", "velador", "ñoquis de espinaca", "vino tinto merlot", "vinilos", "fuego"]
	var tieneFuego = false
	const extras = #{}
	
	override method initialize(){
		super()
		super()
	}
	
	override method puedeSimular(){
		return requisitos.contains("muebles de pino")
	}
}

class Caracterizador inherits Simulador {
	var disfraces = ["NASA", "FBI", "vampiro", "fiscal", "chef", "militar"]
	const pseudonimo
	
	override method puedeSimular(){
		return pseudonimo == "Máximo Cozzetti"
	}
}

class Tecnico inherits Simulador {
	var equipamientoAdquirido = ["un puma", "un helicóptero", "betún"]
	var equipamientoPendiente = []	
	
	override method cuantoCobra() {
		return equipamientoAdquirido.size() * 2000
	}

	override method puedeSimular(){
		return equipamientoPendiente.isEmpty()	
	}
}

class Investigador inherits Simulador {
	override method	cuantoCobra() {
		return super() * 1.20
	}

	override method puedeSimular(){
		return true	
	}
}
