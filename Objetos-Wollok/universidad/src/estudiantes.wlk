class Estudiante {

	var notas
	var materiasEnCurso

	method promedio() {
		return notas.sum() / notas.size()
	}

	method desaprobo() {
		return notas.filter({ unaNota => unaNota < 6 }).size()
	}

	method esEjemplar() {
		return notas.all({ unaNota => unaNota >= 8 })
	}

	method pasarDeAnio() {
		const cursadaNueva = self.proximasMaterias()
		materiasEnCurso.addAll(cursadaNueva)
	}

	method proximasMaterias() {
		return materiasEnCurso.map({ materia => materia + "I" })
	}

	method agregarNota(unaNota) {
		notas.add(unaNota)
	}

}

const lucia = new Estudiante(notas = [ 6, 8, 8, 6 ], materiasEnCurso = [ "Analisis Matematico I", "Fisica II" ])

const juan = new Estudiante(notas = [ 4, 7, 9, 9 ], materiasEnCurso = [ "Programacion II", "Sistemas Operativos I", "Analisis Matematico I" ])

const perla = new Estudiante(notas = [ 4, 7, 9, 9 ], materiasEnCurso = [ "Programacion II", "Sistemas Operativos I", "Analisis Matematico I" ])

