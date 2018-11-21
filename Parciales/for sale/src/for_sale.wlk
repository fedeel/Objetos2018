//inmuebles y zonas

class Inmueble {
	const property tamanio
	const property ambientes
	var property operacion
	var property zona
	const property puedeVenderse
		
	method valor() = self.valorBase() + zona.adicionalPorZona()
	//abstracto
	method valorBase()
}

class Casa inherits Inmueble {
	var property valorBase
	
	override method valorBase() = valorBase 
}

class PH inherits Inmueble {
	 const valorPorMetroCuadrado = 14000
	 const valorMinimo = 500000
	
	override method valorBase() =  (valorPorMetroCuadrado * tamanio).min(valorMinimo)
}

class Departamento inherits Inmueble {
	const valorPorAmbiente = 350000
	
	override method valorBase() = valorPorAmbiente * ambientes
}

class Zona {
	 var property adicionalPorZona
}

//
//operaciones 

class Operacion {
	const property inmueble
	var property estado
	//abstracto
	method comision()
}

class Alquiler inherits Operacion {
	const duracionContrato
	
	override method comision() = (duracionContrato * inmueble.valor()) / 50000
}

class Venta inherits Operacion {
	var property inmobiliaria //para la comision por inmobiliaria
	
	override method comision() = inmueble.valor() * inmobiliaria.comisionFijaPorVenta()
	
}

class Estado {
	
	method reservar(operacion, empleado, cliente) {	}
	
	method cerrar(operacion, empleado, cliente){}
}

class Abierta inherits Estado{
	method estado() = abierta
}

class Cerrada inherits Estado{
	method estado() = cerrada
}
class Reservada inherits Estado{
	method estado() = reservada
}

object cerrada{}
object abierta{}
object reservada{}

//
//inmobiliarias y emplados

class Inmobiliaria {
	var property comisionFijaPorVenta
	var property empleados
	
	method mejorEmpleadoSegun(criterio) = empleados.max({criterio}) //criterio de la forma empleado.metodo(), algunos de los cuales estan definidos en empleado, puedo definir cuantos yo quiera sin modificar la implementacion de empleado

}

class Empleado {
	var property operaciones
	
	method totalComisiones() = operaciones.sum({unaOperacion=>unaOperacion.comision()})
	method operacionesCerradas() = operaciones.filter({unaOperacion=> unaOperacion.estado() ==  cerrada})
	method operacionesReservas() =  operaciones.filter({unaOperacion=> unaOperacion.estado() == reservada})
	
}

//me canse, a la goma este parcial

