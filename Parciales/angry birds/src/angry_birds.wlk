class Pajaro {
	var property fuerza
	var property ira
	var property cantidadDeEnojos
	
	//abstracto, punto 1.a
	method calcularFuerza()
	//punto 1.b
	method enojarse() {
		ira = ira * 2
		cantidadDeEnojos += 1
	} 
	method esFuerte() = self.calcularFuerza() > 50
	//punto 2
	method tranquilizarse() {
		ira =  (ira - 5).max(0)
	}
}

class PajaroComun inherits Pajaro {

	override method calcularFuerza() = 2 * ira
}

class PajaroRencoroso inherits Pajaro{
		
	override method calcularFuerza() = ira * cantidadDeEnojos 
}

object red inherits PajaroRencoroso {
	var multiplicadorDeIra = 10
	
	override method calcularFuerza() = super() * multiplicadorDeIra	
}

object terence inherits PajaroRencoroso {
	var property multiplicadorDeIra
	
	override method calcularFuerza() = super() * multiplicadorDeIra
}

object bomb inherits PajaroComun {
	const property topeMaximoDeFuerzaPermitido = 9000
		
	override method calcularFuerza() = super().min(topeMaximoDeFuerzaPermitido)
}

object chuck inherits Pajaro {
	var property velocidadActual
	
	override method calcularFuerza() {
		if (velocidadActual <= 80) return 150 
		else return 150 + (velocidadActual - 80) * 5
	}
	
	override method enojarse() {
		velocidadActual = velocidadActual * 2
	}
	
	override method tranquilizarse(){}
}

object matilda inherits PajaroComun {
	var property cantidadDeHuevos = []
	
	override method calcularFuerza() = super() + cantidadDeHuevos.sum({unHuevo=>unHuevo.fuerza()})
	
	override method enojarse(){ 
		self.ponerUnHuevo()
	}	
	method ponerUnHuevo() = cantidadDeHuevos.add(new Huevo(2))
}

class Huevo {
	var property peso
		
	constructor(_peso) {
		peso = _peso
	}
	
	method fuerza() = peso
}


object islaPajaro {
	var property pajarosHabitantes
	
	method losMasFuertesDeLaIsla() = pajarosHabitantes.filter({unPajaro=>unPajaro.esFuerte()})
	method fuerzaDeLaIsla() = pajarosHabitantes.losMasFuertesDeLaIsla().sum({unPajaro=>unPajaro.calcularFuerza()})
	
	method sesionDeManejoDeIraConMatilda() = pajarosHabitantes.forEach({pajaritoDeLaIsla=>pajaritoDeLaIsla.tranquilizarse()})
	method invasionDeCerditos(cantidadDeCerditos) = pajarosHabitantes.forEach({pajarito=>pajarito.ira(cantidadDeCerditos.div(100))})
	method fiestaSorpresa(homenajeados){
		if (homenajeados.isEmpty()) throw new Exception("No hay pajaros homenajeados")
		else{
			return homenajeados.forEach({pajaritoHomenajeado=>pajaritoHomenajeado.enojarse()})
		}
		
	}
	
	//si no hay ninguno explota, se le intentara pasar el mensaje enojarse al objeto null, quien no lo entiende
	
	//modelo el ataque a isla cerdito
	
	method puedeDerribar(unPajaro,unObstaculo) = unPajaro.calcularFuerza() > unObstaculo.resistencia()
	method seRecuperaronLosHuevos() = islaCerdito.obstaculosPresentes().isEmpty()
	
	method atacarIslaCerdito() {
		pajarosHabitantes.forEach({unPajaro=>islaCerdito.resistirAtaque(unPajaro)})
	}
	
	
}

/* 1.a
 * unPajaroCualquiera.calcularFuerza() , los pajaros implementan este metodo de forma distinta compartiendo la interfaz
 * 1.b
 * unPajaroCualquiera.enojarse(), los pajaros implementan este metodo de forma distinta, compartiendo la interfaz
 * 1.c
 * islaPajaro.losMasFuertesDeLaIsla() retorna una lista con los pajaros mas fuertes de la isla
 * 1.d
 * islaPajaro.fuerzaDeLaIsla() retorna la fuerza de la isla
 * */
 
 /*4. se deberia instanciar una de las clases de pajaros para generar pajaros nuevos.La herencia simple, que permite, en el contexto de esta solucion, instanciar
  * distintos tipos de pajaros con distintas caracteristicas.
  */
  
  object islaCerdito {
	var property obstaculosPresentes //lista de obstaculos
	
	method resistirAtaque(unPajaro){
		if(unPajaro.puedeDerribar(unPajaro,obstaculosPresentes.head())){
			obstaculosPresentes.remove(obstaculosPresentes.head())
		}
	}
}

class Obstaculo {
	//abstracto	
	method resistencia()
}

class Estructura inherits Obstaculo {
	var property anchoPared
	
	override method resistencia() = anchoPared
}

class ParedVidrio inherits Estructura {
	override method resistencia() = super() * 10
}

class ParedMadera inherits Estructura {
	override method resistencia() = super() * 25
}

class ParedPiedra inherits Estructura {
	override method resistencia() = super() * 50
}

class CerditoObrero inherits Obstaculo {
	override method resistencia() = 50
}

class CerditoArmado {
	var property armaduraEquipada
	
	method resistencia() = 10 * armaduraEquipada.resistenciaProteccion()
}

class Armadura {
	var property resistenciaProteccion
}

