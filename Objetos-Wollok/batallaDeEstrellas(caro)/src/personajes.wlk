object pamela {

	var botiquin = [ "algodon", "agua oxigenada", "cinta de papel", "cinta de papel" ]
	var energia = 6000
	const gritoDeVictoria = "Acá pasó la Pamela"

	method luchar(unEnemigo) {
		energia += 400
	}

	method energia() = energia

	method botiquin() = botiquin

	method gritoDeVictoria() = gritoDeVictoria

	method perderEnergia(cantidad) {
		energia -= cantidad
	}

	method cantidadDeEquipamiento() {
		botiquin.size()
	}

	method ultimoObjeto() {
		return botiquin.last()
	}

	method perderUltimoObjeto() {
		botiquin.remove(self.ultimoObjeto())
	}

	method estaVivo() {
		return energia > 0
	}
}

object pocardo {

	var botiquin = [ "guitarra", "curitas", "cotonetes" ]
	var energia = 5600
	const gritoDeVictoria = "¡Siente el poder de la música!"

	method luchar(unEnemigo) {
		energia += 500
	}

	method energia() = energia

	method botiquin() = botiquin

	method gritoDeVictoria() = gritoDeVictoria

	method perderEnergia(cantidad) {
		energia -= cantidad
	}

	method cantidadDeEquipamiento() {
		botiquin.size()
	}

	method ultimoObjeto() {
		return botiquin.last()
	}

	method perderUltimoObjeto() {
		botiquin.remove(self.ultimoObjeto())
	}

	method estaVivo() {
		return energia > 0
	}
}

object tulipan {

	var botiquin = [ "rastrillo", "maceta", "maceta", "manguera" ]
	var energia = 8400
	const gritoDeVictoria = "Hora de cuidar a las plantas"

	method energia() = energia

	method botiquin() = botiquin

	method gritoDeVictoria() = gritoDeVictoria

	method luchar(unEnemigo) {
		unEnemigo.perderEnergia(unEnemigo.energia() / 2)
	}

	method perderEnergia(cantidad) {
		energia -= cantidad
	}

	method cantidadDeEquipamiento() {
		botiquin.size()
	}

	method ultimoObjeto() {
		return botiquin.last()
	}

	method perderUltimoObjeto() {
		botiquin.remove(self.ultimoObjeto())
	}

	method estaVivo() {
		return energia > 0
	}

}

object toro {

	var botiquin = []
	var energia = 7800
	const gritoDeVictoria = "No se metan con el toro"

	method energia() = energia

	method botiquin() = botiquin

	method gritoDeVictoria() = gritoDeVictoria

	method luchar(unEnemigo) {
		self.quitarEnergiaPorElemento(unEnemigo)
		self.robarElUltimoElemento(unEnemigo)
	}

	method quitarEnergiaPorElemento(unEnemigo) {
		unEnemigo.perderEnergia(unEnemigo.cantidadDeEquipamiento() * 200)
	}

	method robarElUltimoElemento(unEnemigo) {
		if (!botiquin.contains(unEnemigo.ultimoObjeto())) {
			botiquin.add((unEnemigo.ultimoObjeto()))
			unEnemigo.perderUltimoObjeto()
		}
	}

	method perderEnergia(cantidad) {
		energia -= cantidad
	}

	method estaVivo() {
		return energia > 0
	}
}

