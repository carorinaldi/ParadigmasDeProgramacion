import estudiantes.*

object profesor {
	var cfd = 3
	var estudiantes = [lucia,juan, perla]
	
	method estudiantesEjemplares() {
		estudiantes.filter({unEstudiante => unEstudiante.esEjemplar()})
	}
	
	method promedioDeNotasDelCurso() {
		return estudiantes.sum({unEstudiante => unEstudiante.promedio()}) / estudiantes.size()
	}
	
	method evaluarEstudiantes() {
		estudiantes.forEach({unEstudiante => unEstudiante.agregarNota(self.notaExamenSorpresa())})
	}
	
	method notaExamenSorpresa() {
		return self.promedioDeNotasDelCurso() + cfd
	}
}
