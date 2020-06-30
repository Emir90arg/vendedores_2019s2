import geografia.*

class Vendedor{
	var property certificaciones = []
	
	method puedeTrabajarEn(ciudad)
	
	method agregarCertificacion(certificacion){
		certificaciones.add(certificacion)
	}
	method certifiacionesEnProductos(){
		return certificaciones.count({certificado => certificado.deProducto()})
	}
	method certifiacionesDeOtroTipo(){
		return certificaciones.count({certificado => not certificado.deProducto()})
	}
	method esVersatil(){
		return certificaciones.size() > 3 and
		self.certifiacionesEnProductos() >= 1 and
		self.certifiacionesDeOtroTipo()  >=1
	}
	method cantidadDePuntosTotales(){
		return certificaciones.sum({certificado=> certificado.puntos()})
	}
	method esFirme(){
		return self.cantidadDePuntosTotales() >= 30
	}
	method esInfluyente(){
		return false
	}
	method esGenerico(){
		return certificaciones.any({certificado=> not certificado.deProducto()})
	}
	method tieneAfinidad(centro){
		return self.puedeTrabajarEn(centro.ubicacionCiudad())
	}
	method esCandidato(centro){
		return self.esVersatil() and self.tieneAfinidad(centro)
	}
	method esPersonaFisica() = true
}
class VendedorFijo inherits Vendedor{
	var property ciudadDondeVive 
	
	override method puedeTrabajarEn(ciudad){
		return ciudadDondeVive == ciudad
	}
}

class VendedorViajante inherits Vendedor{
	var property provinciasHabilitadas =[]	
	
	override method puedeTrabajarEn(ciudad){
		//return provinciasHabilitadas.any({provincia=> provincia == ciudad.provincia()})
		return provinciasHabilitadas.contains(ciudad.provincia())
	}

	override method esInfluyente(){
		return provinciasHabilitadas.sum({provicia=> provicia.poblacion()}) > 10000000
	}
		
}

class ComercioCorresponsal inherits Vendedor{
	var property ciudadadesDondeHaySucursales = []
	
	override method puedeTrabajarEn(ciudad){
		return ciudadadesDondeHaySucursales.contains(ciudad)
	}
	method cantidadCiudadesConSucursales(){
		return ciudadadesDondeHaySucursales.asSet().size()
	}
	method cantidadProvinciasConSucursales(){
		return ciudadadesDondeHaySucursales.map({ciudad=> ciudad.provincia()}).asSet().size()
	}
	override method esInfluyente(){
		return self.cantidadCiudadesConSucursales() > 5 or
			self.cantidadProvinciasConSucursales() >= 3
	}
	override method tieneAfinidad(centro){
		return super(centro) and
		ciudadadesDondeHaySucursales.any({sucursal=> centro.puedeCubrirCiudad(sucursal)})
	}
	override method esPersonaFisica() = false
}
class Certificacion{
	var property deProducto 
	var property puntos 
}    













