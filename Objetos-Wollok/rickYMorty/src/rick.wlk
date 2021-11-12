import familiares.*

class Rick {
	var nivelDeDemencia
	var acompaniante
	
	method irseDeAventuras(){
		acompaniante.irseDeAventuras(self)
	}

	method enloquecer(unaCantidad){
		nivelDeDemencia += unaCantidad
	}

	method tranquilizar(unaCantidad){
		nivelDeDemencia -= unaCantidad
	}
}
