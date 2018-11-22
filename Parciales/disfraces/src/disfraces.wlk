class Fiesta {
	var property lugar
	var property fecha
	var property invitados //coleccion de personas
	
	//Punto 2
	method esUnBodrio() = invitados.all({unInvitado=> unInvitado.noEstaConformeConSuDisfraz(self)})
	//Punto 3
	method elMejorDisfrazDeLaFiesta() = invitados.max({unInvitado=> unInvitado.puntuacionDeSuDisfraz(self)})
	//Punto 4
	method puedenIntercambiarseDisfraces(unAsistente,otroAsistente) {
		return  self.estaEnLaFiesta(unAsistente) && self.estaEnLaFiesta(otroAsistente) &&
				self.algunoNoEstaConformeConSuDisfraz(unAsistente,otroAsistente) &&
				self.siCambianTrajesQuedanConformes(unAsistente,otroAsistente)
	}
	
	method estaEnLaFiesta(unAsistente) = invitados.contains(unAsistente)
	method algunoNoEstaConformeConSuDisfraz(unAsistente,otroAsistente) = unAsistente.noEstaConformeConSuDisfraz(self) || otroAsistente.noEstaConformeConSuDisfraz(self)
	method siCambianTrajesQuedanConformes(unAsistente,otroAsistente) = unAsistente.conformeSiSePoneDisfrazDe(otroAsistente,self) && otroAsistente.conformeSiSePoneDisfrazDe(otroAsistente,self)
	
	//Punto 5
	method invitar(nuevoAsistente) {
		if(self.puedePasar(nuevoAsistente)) invitados.add(nuevoAsistente)
		else throw new Exception("No es posible invitar a este asistente a esta fiesta.")
	}
	
	method puedePasar(nuevoAsistente) = nuevoAsistente.disfraz() != null && !invitados.contains(nuevoAsistente)
		
}

object fiestaInolvidable inherits Fiesta{
	override method invitar(nuevoAsistente) {
		if(self.puedePasar(nuevoAsistente) && self.esGlamoroso(nuevoAsistente)) invitados.add(nuevoAsistente)
		else throw new Exception("Esta fiesta es muy top para este invitado")
	}
	
	method esGlamoroso(nuevoAsistente) = nuevoAsistente.esSexy() && nuevoAsistente.estaConformeConSuDisfraz(self)
}


class Invitado {
	var property disfraz
	var property edad
	var property personalidad
	const property tipo //esto no cambia
	
	method esViejo() = edad > 50
	method esSexy() = personalidad.esSexySegunPersonalidad(self)
	
	method estaConformeConSuDisfraz(unaFiesta) = self.puntuacionDeSuDisfraz(unaFiesta) > 10 && tipo.estaConformeCon(self,disfraz,unaFiesta)
	method noEstaConformeConSuDisfraz(unaFiesta) = !self.estaConformeConSuDisfraz(unaFiesta)
	
	method puntuacionDeSuDisfraz(unaFiesta) = disfraz.puntaje(unaFiesta,self)
	
	//Para el punto 4, cambia de disfraz por el de otro y valida si queda conforme
	method conformeSiSePoneDisfrazDe(otroInvitado,unaFiesta){
		disfraz = otroInvitado.disfraz()
		return self.estaConformeConSuDisfraz(unaFiesta)
	}
	
}

//Personalidades
object alegre {
	method esSexySegunPersonalidad(persona) = false
}

object taciturna {
	method esSexySegunPersonalidad(persona) = persona.edad() < 30
}

//Tipos
object caprichoso {
	method estaConformeCon(unaPersona,disfraz,unaFiesta) = disfraz.nombre().size().even()
}

object pretencioso {
	method estaConformeCon(unaPersona,disfraz,unaFiesta) = disfraz.fechaConfeccion()
}

class Numerologo {
	var property cifraPreferida
	
	method estaConformeCon(unaPersona,disfraz,unaFiesta) = disfraz.puntaje(unaFiesta,unaPersona) == cifraPreferida
}


//Disfraces y caracteristicas
class Disfraz {
	const property nombre
	const property fechaConfeccion
	var property caracteristicas
	
	// Punto 1		
	method puntaje(unaFiesta,unaPersona) = caracteristicas.sum({caracteristica=> caracteristica.puntajeSegunCaracteristica(self,unaFiesta,unaPersona)})
}

class Gracioso {
	const property nivelDeGracia
		
	method puntajeSegunCaracteristica(unDisfraz,unaFiesta,unaPersona) {
		if (unaPersona.esViejo()) return nivelDeGracia * 3
		else return nivelDeGracia
	}
}

class Tobara {
	const property fechaCompra
	
	method puntajeSegunCaracteristica(unDisfraz,unaFiesta,unaPersona) {
		if (unaFiesta.fecha() - fechaCompra >= 2) return 5
		else return 3		
	}
}

class Careta {
	const property personajeCareta
	
	method puntajeSegunCaracteristica(unDisfraz,unaFiesta,unaPersona)  = personajeCareta.valor()
}

class PersonajeCareta {
	const property valor
}

class Sexy {
	
	method puntajeSegunCaracteristica(unDisfraz,unaFiesta,unaPersona) {
		if (unaPersona.esSexy()) return 15
		else return 2
	}
}
