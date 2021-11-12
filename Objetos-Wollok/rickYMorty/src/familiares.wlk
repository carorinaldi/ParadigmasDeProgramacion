import rick.*

class Morty {
	var saludMental 
	
	method puedeIrDeAventuras() = true
	
	method irseDeAventuras(unRick) {
		saludMental -= 30
		unRick.enloquecer(50)
	}
}

class Beth  {
	var afectoPorElPadre
	
	method puedeIrDeAventuras() = true

	method irseDeAventuras(unRick) {
		afectoPorElPadre += 10
		unRick.tranquilizar(20)
	}	
}

class Summer inherits Beth	{

  	method esMiercoles() {
   	 return new Date().dayOfWeek() == wednesday 
  }
	override method irseDeAventuras(unRick) {
		if(!self.esMiercoles()) {throw new Exception(message = "No puedo ir de Aventuas si no es miercoles")}
		super(unRick)
	}
}	

object jerry {
	method puedeIrDeAventuras() = false
	
	method irseDeAventuras(unRick) {
		throw new Exception(message = "Soy muy tonto y no me da para ir de aventuras")
	}
}