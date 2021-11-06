import centrales.*

object springfield {
  const centrales = [centralNuclear,centralCarbon,centralEolica]
  var necesidadEnergetica = 1000000
  
  method centralesContaminantes() {
    return centrales.filter({unaCentral => unaCentral.puedeContaminar()})
  }
  
  method cubreNecesidad() {
   return self.totalProduccionCentrales() >= necesidadEnergetica
  }

  method necesidadEnergetica(unaNecesidad) {
  necesidadEnergetica = unaNecesidad}

  method totalProduccionCentrales() {
    return self.sumarProducciones(centrales)
  }
  
  method estaAlHorno() {
  	return self.sumarProducciones(self.centralesContaminantes()) / self.totalProduccionCentrales() > 0.5
  }
  
  method sumarProducciones(unasCentrales) {
  	return unasCentrales.sum({unaCentral=> unaCentral.produccionEnergetica()})
  }
  method produceMayorEnergia() {
    return centrales.max({unaCiudad => unaCiudad.produccionEnergetica()})
  }
}

object albuquerque {
  const centrales = [centralHidroelectrica]
  const caudalDelRio = 150
  //var necesidadEnergetica = 1000000
  method caudalDelRio() = caudalDelRio  
  
  method produccionEnergetica() {
    return self.totalProduccionCentrales()
  }
  
  method totalProduccionCentrales() {
    return self.sumarProducciones(centrales)
  }
    
  method sumarProducciones(unasCentrales) {
  	return unasCentrales.sum({unaCentral=> unaCentral.produccionEnergetica()})
  }
  
  method produceMayorEnergia() {
    return centrales.max({unaCiudad => unaCiudad.produccionEnergetica()})
  }
}

