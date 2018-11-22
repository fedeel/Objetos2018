class Ninia {
	var nivelFelicidad = 1000
	var property emocionDominante
	var property recuerdosDelDia = []
	var pensamientosCentrales = #{}//coleccion
	var memoriaLargoPlazo = []
	
	//Punto 1
	method vivirEvento(recuerdoAsociado) {recuerdosDelDia.add(recuerdoAsociado)} 
	
	//Punto 2	
	method asentarRecuerdo(recuerdoAsociado) {
		if(self.vivioUnEvento(recuerdoAsociado)) recuerdoAsociado.serAsentado(self)
		else throw new Exception("La ninia no vivio el evento indicado")
	} 
	
	method vivioUnEvento(recuerdoAsociado) = recuerdosDelDia.contains(recuerdoAsociado)	
	method estaFeliz() = nivelFelicidad > 500
	method convertirEnPensamientoCentral(unRecuerdo) {pensamientosCentrales.add(unRecuerdo)} 
	method entristecerse(porcentaje) {
		if((nivelFelicidad - nivelFelicidad * porcentaje) >= 1) self.reducirFelicidad(porcentaje)
		else throw new Exception("No es posible entristecerse tanto :( ")
	}
	method reducirFelicidad(porcentaje) {
		nivelFelicidad = nivelFelicidad - nivelFelicidad * porcentaje
	}
	
	//Punto 3
	method conocerEventosRecientesDelDia() = recuerdosDelDia.reverse().take(5)
	
	//Punto 4
	method conocerPensamientosCentrales() = pensamientosCentrales
	
	//Punto 5
	method conocerPensamientosCentralesDificilesDeExplicar() = pensamientosCentrales.filter({unPensamiento=> unPensamiento.esDificilDeExplicar()})
	
	//NOTA: un pensamiento es una categoria especial de recuerdos para el diseño de esta solucion, tienen la misma estructura
	
	//Punto 6
	method niegaRecuerdos() = emocionDominante.niegaRecuerdos(recuerdosDelDia)
	
	method negarRecuerdos() = emocionDominante.negarRecuerdos(recuerdosDelDia)
	
	//Punto 7
	method aDormir(palabraClave) {
		self.asentamiento()
		self.asentamientoSelectivo(palabraClave)
		self.profundizacion()
		self.controlHormonal()
		self.restauracionCognitiva()
		self.liberarRecuerdosDelDia()
	}
	
	method asentamiento() {recuerdosDelDia.forEach({unRecuerdo=> unRecuerdo.serAsentado(self)})} 
	method asentamientoSelectivo(palabraClave) {recuerdosDelDia.filter({unRecuerdo=> unRecuerdo.contienePalabraClave(palabraClave)}).forEach({unRecuerdo=> unRecuerdo.serAsentado(self)})}
	method profundizacion() {recuerdosDelDia.obtenerRecuerdosParaMemoria().forEach({unRecuerdo=> memoriaLargoPlazo.add(unRecuerdo)})} 
	method controlHormonal() {} //pendiente de terminar
	method restauracionCognitiva() {self.restaurarFelicidad(100)}
	method liberarRecuerdosDelDia() = recuerdosDelDia.forEach({unRecuerdo=> recuerdosDelDia.remove(unRecuerdo)})
	
	//Metodos auxiliares para punto 7	
	method obtenerRecuerdosParaMemoria() = emocionDominante.negarRecuerdos(recuerdosDelDia)
	method restaurarFelicidad(felicidadARestaurar) {
		nivelFelicidad = 1000.min(nivelFelicidad + felicidadARestaurar)
	}
			
}

class Emocion {
	
	method niegaRecuerdos(recuerdosDelDia)
	method negarRecuerdos(recuerdosDelDia)
}

object alegria inherits Emocion {

	override method niegaRecuerdos(recuerdosDelDia) = recuerdosDelDia.any({unRecuerdo=> !unRecuerdo.esRecuerdoFeliz()})
	override method negarRecuerdos(recuerdosDelDia) = recuerdosDelDia.filter({unRecuerdo=> unRecuerdo.esRecuerdoFeliz()})
}

object tristeza inherits Emocion {
	
	override method niegaRecuerdos(recuerdosDelDia) = recuerdosDelDia.any({unRecuerdo=> unRecuerdo.esRecuerdoFeliz()})
	override method negarRecuerdos(recuerdosDelDia) = recuerdosDelDia.filter({unRecuerdo=> !unRecuerdo.esRecuerdoFeliz()})
}

object disgusto inherits Emocion {
	
	override method niegaRecuerdos(recuerdosDelDia) = false
	override method negarRecuerdos(recuerdosDelDia) {}
}

object furia inherits Emocion {
	
	override method niegaRecuerdos(recuerdosDelDia) = false
	override method negarRecuerdos(recuerdosDelDia) {}
}

object temor inherits Emocion {
	
	override method niegaRecuerdos(recuerdosDelDia) = false
	override method negarRecuerdos(recuerdosDelDia) {}
}


object riley inherits Ninia{}

//riley como wko

class Recuerdo {
	const property descripcion
	const property fecha
	const property emocionDominante
		
	method serAsentado(ninia)
	method esDificilDeExplicar() = descripcion.words() > 10
	method contienePalabraClave(palabraClave) = descripcion.contains(palabraClave) //string acepta contains?
}

class RecuerdoAlegre inherits Recuerdo {
	
	override method serAsentado(ninia) {
		if(ninia.estaFeliz()) ninia.convertirEnPensamientoCentral(self)
	}
	
	method esRecuerdoFeliz() = true		
}

class RecuerdoTriste inherits Recuerdo {
	
	override method serAsentado(ninia) {
		ninia.convertirEnPensamientoCentral(self)
		ninia.entristecerse(0.1)
	}
}

class RecuerdoDisgusto inherits Recuerdo {
	
	override method serAsentado(ninia) {}
}

class RecuerdoFurioso inherits Recuerdo {
	
	override method serAsentado(ninia) {}
}

class RecuerdoTemoroso inherits Recuerdo {
	
	override method serAsentado(ninia)  {}
}