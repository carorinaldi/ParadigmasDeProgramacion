import ciudades.*

object centralHidroelectrica {
  
  method produccionEnergetica(){
    return 2 * albuquerque.caudalDelRio()
  }
}



object centralNuclear {
  var cantidadVarillasDeUranio = 200
  
  method produccionEnergetica(){
    return 0.1 * cantidadVarillasDeUranio
  }
  
  method puedeContaminar() {
    return cantidadVarillasDeUranio > 20  
  }
}

object centralCarbon {
  var capacidadEnToneladas = 1000
  
  method produccionEnergetica(){
    return 0.5 + capacidadEnToneladas * 0.9
  }
  
  method puedeContaminar() {
    return true 
  }
}

object centralEolica {
  var turbinas = [turbina]
  
  method produccionEnergetica(){
    return turbinas.sum({unaTurbina => unaTurbina.produccion()})
  }
  
  method puedeContaminar() {
    return false
  }
}

object turbina {
  method produccion() = 0.2 * 10
}