import personajes.*
object combate {
	const equipo1 = [pamela,pocardo]
	const equipo2 = [tulipan,toro]
	
	method equipo1() = equipo1
	method equipo2() = equipo2
	
	method batallar(){
		self.enfrentar(equipo1,equipo2)
		self.enfrentar(equipo2,equipo1)
	}
		
	method enfrentar(unEquipo,otroEquipo) {
		unEquipo.forEach({unPersonaje => self.personajeLucharContraEquipo(unPersonaje,otroEquipo)})
	}
	
	method personajeLucharContraEquipo(personaje,equipo) {
		equipo.forEach({enemigo => personaje.luchar(enemigo)})
	}

	method energiaDe(unEquipo) {
		return unEquipo.sum({unPersonaje => unPersonaje.energia()})		
	}	
	
	method ganadores() {
		if(self.energiaDe(equipo1) > self.energiaDe(equipo2)) {return equipo1}
		else {return equipo2}
	}
	
	method sobrevivientes(unEquipo) {
		unEquipo.filter({personaje=>personaje.estavivo()})
	}

	method gritoGanadores() {
		return self.sobrevivientes(self.ganadores()).map({personaje => personaje.gritoDeVictoria()})
	}
}
