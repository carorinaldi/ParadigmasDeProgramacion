import ciudades.*
import centrales.*

object laRegion {
  const ciudades = [springfield,albuquerque]

  method agregarCiudad(unaCiudad) {
  ciudades.add(unaCiudad)
  }
  
  method principalCiudadProductora() {
    return ciudades.max({unaCiudad => unaCiudad.totalProduccionCentrales()})
  }

  method principalesCentrales(){
    return ciudades.map({unaCiudad=>unaCiudad.produceMayorEnergia()})
  }
}
	

