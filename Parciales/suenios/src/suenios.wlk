class Persona {
	const property edad
	var property quiereEstudiar
	var property sueldoPretendido
	var property quiereViajarA
	var property tieneHijos
	var property sueniosPendientes
	const property sueniosCumplidos
	var property tipo
	
	method cumplirSuenio(unSuenio) {
		if (unSuenio.puedeSerCumplidoPor(self)){
			sueniosPendientes.remove(unSuenio)
			sueniosCumplidos.add(unSuenio)
			unSuenio.serCumplido(self)
		}
		else
		{
			throw new Exception("No es posible cumplir este suenio :(")
		}
	}
	//una persona no cumplio un suenio si lo tiene como pendiente
	method noCumplio(unSuenio) = sueniosPendientes.contains(unSuenio)
	
	//Punto 3
	method cumplirSuenioMasPreciado() = tipo.suenioACumplir(sueniosPendientes)
	
	//Punto 4
	method calcularFelicidad(listaDeSuenios) = listaDeSuenios.sum({unSuenio=> unSuenio.felicidonios()})
	method esFeliz() = self.calcularFelicidad(sueniosCumplidos) > self.calcularFelicidad(sueniosPendientes)
	
	//Punto 5
	method esAmbicioso() {
		var sueniosPendientesYCumplidos = sueniosPendientes + sueniosCumplidos
		return sueniosPendientesYCumplidos.filter({unSuenio=> unSuenio.felicidonios() > 100}).size() > 3
	}	
}


//Punto 1

class Suenio {
	const property felicidonios
	
	method serCumplido(unaPersona)
	method puedeSerCumplidoPor(unaPersona)
}

class Recibirse inherits Suenio {
	const property carrera
	
	override method puedeSerCumplidoPor(unaPersona)	= unaPersona.quiereEstudiar() == carrera && unaPersona.noCumplio(self)
}

object tenerHijo inherits Suenio {
		
	override method puedeSerCumplidoPor(unaPersona) = true
	
	override method serCumplido(unaPersona) = unaPersona.tieneHijos(true)

}

class AdoptarHijos inherits Suenio {
	const property cantidadDeHijosAdopcion
	
	override method puedeSerCumplidoPor(unaPersona) = !unaPersona.tieneHijos()
	override method serCumplido(unaPersona) = unaPersona.tieneHijos(true)
}

class Viajar inherits Suenio {
	const property destino
	
	override method puedeSerCumplidoPor(unaPersona) = true
}

class Laburar inherits Suenio {
	const property sueldo
	
	override method puedeSerCumplidoPor(unaPersona) = unaPersona.sueldoPretendido() < sueldo
}

//Punto 2

class SuenioMultiple inherits Suenio {
	const property sueniosACumplir
	
	override method puedeSerCumplidoPor(unaPersona) = sueniosACumplir.all({unSuenio=> unSuenio.puedeSerCumplidoPor(unaPersona)})
	override method serCumplido(unaPersona) {
		 sueniosACumplir.forEach({unSuenio=> unaPersona.sueniosCumplidos().add(unSuenio)})
		 sueniosACumplir.forEach({unSuenio=> unaPersona.sueniosPendientes().remove(unSuenio)})
	} //me resulta medio raro modificar el estado de las personas desde el suenio multiple, pero es la forma que se me ocurrio para agregar y quitar los suenios uno a uno de las listas de cumplidos y pendientes respectivamente
}

//Punto 3

object realista {
	
	method suenioACumplir(sueniosPendientes) = sueniosPendientes.max({unSuenio=> unSuenio.felicidonios()})
}

object alocado {
	
	method suenioACumplir(sueniosPendientes) = sueniosPendientes.anyOne()
}

object obsesivo {
	
	method suenioACumplir(sueniosPendientes) = sueniosPendientes.first()
}

/*Punto 6
 *Si, al optar por modelar el tipo de persona como objetos, y tener un atributo que apunte a uno de estos objetos en particular,
 * estoy utilizando la composicion como herramienta, lo cual me permite agregar tipos con facilidad.
 * Esto implica, claro, una mayor complejidad en el mantenimiento del codigo y una repeticion de logica que no tendria lugar
 * de haber trabajado con herencia. Cabe aclarar que, de haber adoptado el mecanismo de herencia para modelar los distintos tipos de persona,
 * heredando a partir de la clase Persona (tratando a esta ultima como abstracta), no podria cambiar el tipo con la facilidad que la composicion me permite.
 */
