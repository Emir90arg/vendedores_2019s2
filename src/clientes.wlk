import vendedores.*

class ClienteInseguro {
	method PuedeSerAtendido(vendedor){
		return vendedor.esVersatil() and vendedor.esFirme()
	}
}

class ClienteDetallista inherits ClienteInseguro {
	override method PuedeSerAtendido(vendedor){
		return vendedor.certifiacionesEnProductos() >= 3
	}
}

class ClienteHumanista inherits ClienteInseguro {
	override method PuedeSerAtendido(vendedor){
		return vendedor.esPersonaFisica()
	}
}

