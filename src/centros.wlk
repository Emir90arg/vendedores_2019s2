import vendedores.*
import geografia.*

class CentroDeDistribucion{
	var property ubicacionCiudad
	var property vendedores =[]
	
	method vendedorYaEstaRegistrado(vendedor){
		return vendedores.contains(vendedor)
	}
	method agregarVendedor(vendedor){
		if (not self.vendedorYaEstaRegistrado(vendedor)){
			vendedores.add(vendedor)
		}
		else{
			throw new Exception(message = "El vendedor ya esta registrado")
		}
	}
	method vendedorEstrella(){
		return vendedores.max({vendedor=> vendedor.cantidadDePuntosTotales()})
	}
	method puedeCubrirCiudad(ciudad){
		return vendedores.any({vendedor=> vendedor.puedeTrabajarEn(ciudad)})
	}
	method vendedoresGenericosRegistrados(){
		return vendedores.filter({vendedor=> vendedor.esGenerico()})
	}
	method cantidadVendedoresFirmes(){
		return vendedores.count({vendedor=> vendedor.esFirme()})
	}
	method centroEsRobusto(){
		return self.cantidadVendedoresFirmes() >= 3
	}
	method repartirCertificacion(certificado){
		vendedores.forEach({vendedor=> vendedor.agregarCertificacion(certificado)})
	}
} 

