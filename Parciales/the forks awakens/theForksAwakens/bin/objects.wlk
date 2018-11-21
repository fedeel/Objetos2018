class Planeta {
	const poblacion = #{}
	
	method poder() = poblacion.sum({unPoblador => unPoblador.poder()})
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
	const property midiclorianos
	var property lado //al tener esto estoy evitando quedarme con la herencia, entonces me voy hacia la composicion
	//lo importante del lado como representacion en un objeto aparte (seria un WKO), el lado no tiene
	//que ser polimorfico con la clase persona o maestro 
	var property tiempoQueLleva
	var property energiaDelSable
	
	override method poder() = super() + lado.poderDeSable(self) + midiclorianos/1000
}


class Elemento {
	var property potencia
}

//WKOs

object ladoOscuro{
	method poderDelSable(sith)
}

object ladoLuminoso{
	method poderDelSable(jedi) = jedi.energiaDelSable() + jedi.tiempoQueLleva()
}

/*la herencia, como mecanismo, tiene la complicacion de si la "erro" en la forma en la que modelo
 * mi dominio en el sistema, luego los refactor se vuelven mas complicados. Al usar herencia, puedo hacer, por ejemplo,
 * que los soldados apunten a un estado dentro de otro objeto, sin establecere herencia. El problema de esto es que, a pesar de
 * que es mas flexible superficialmente, se vuelve mas dificil de mantener, a diferencia de la herencia que es mas representativa de la naturaleza
 * del dominio que intento modelar
 * Ir por esta forma mas flexible es mantener el estado interno de todo el codigo cuando tenga que hacer una modificacion
 */
