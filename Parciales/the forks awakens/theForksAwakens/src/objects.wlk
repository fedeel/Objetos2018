class Planeta {
	const poblacion = #{}
	
	method poderPlaneta() = poblacion.sum({unPoblador => unPoblador.poder()})
	method poseeOrden() 
	
	method habitantesSegunPoder() = poblacion.sortedBy({unHabitante,otroHabitante => unHabitante.poder() > otroHabitante.poder()})
	method poderDeLostresHabitantesMasPoderosos() = self.habitantesSegunPoder().take(3).sum({unHabitantePoderoso => unHabitantePoderoso.poder()})
}

class Persona {
	var property valentia
	var property inteligencia

	method poder() = valentia + inteligencia	
}
/*una buena forma de pensar el porque modele el soldado como subclase de persona es el hecho
 */


class Soldado inherits Persona{
	var property equipamiento = []
	override method poder() = super() + equipamiento.sum({unElemento => unElemento.potencia()})
}

class Maestro inherits Persona{
	//const property sableDeLuz
	const property sableDeLuz
	const property midiclorianos
	var property lado
	//al tener esto estoy evitando quedarme con la herencia, entonces me voy hacia la composicion
	//lo importante del lado como representacion en un objeto aparte (seria un WKO), el lado no tiene
	//que ser polimorfico con la clase persona o maestro 
	var property tiempoQueLleva
	var property energiaDelSable
	var property paz
	var property odio
	var property cargaEmocional
	
	override method poder() = super() + lado.poderAdicional(self) + midiclorianos/1000
	
	method vivirSuceso(impactoEmocionalSuceso){
		cargaEmocional = cargaEmocional + impactoEmocionalSuceso
		lado.afectarBalanceDeLaFuerza(self,impactoEmocionalSuceso)
	}
	
	method unirseAlLadoLuminoso(){lado = ladoLuminoso}
	method unirseAlLadoOscuro(){lado = ladoOscuro}

}

class Sable {
	var property poderDeSable
}

class Elemento {
	var property potencia
}

//WKOs

object ladoOscuro{
	method poderAdicional(sith) = (sith.sableDeLuz().poderDeSable()) * 2 + sith.tiempoQueLleva()
	
	method afectarBalanceDeLaFuerza(sith,impactoEmocionalSuceso){
		if(sith.odio() >= impactoEmocionalSuceso) sith.aumentarOdio(0.10) else sith.unirseAlLadoLuminoso()	
	}
	
}

object ladoLuminoso{
	method poderAdicional(jedi) = jedi.sableDeLuz().poderDeSable() + jedi.tiempoQueLleva()
	
	method afectarBalanceDeLaFuerza(jedi,impactoEmocional){
		if (jedi.paz() <= 0) jedi.unirseAlLadoOscuro()
	}
}

/*la herencia, como mecanismo, tiene la complicacion de si la "erro" en la forma en la que modelo
 * mi dominio en el sistema, luego los refactor se vuelven mas complicados. Al usar herencia, puedo hacer, por ejemplo,
 * que los soldados apunten a un estado dentro de otro objeto, sin establecere herencia. El problema de esto es que, a pesar de
 * que es mas flexible superficialmente, se vuelve mas dificil de mantener, a diferencia de la herencia que es mas representativa de la naturaleza
 * del dominio que intento modelar
 * Ir por esta forma mas flexible es mantener el estado interno de todo el codigo cuando tenga que hacer una modificacion
 */
