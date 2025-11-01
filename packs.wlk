class PackViaje{
    var duracionDias
    var precioBase
    var beneficios = []
    var coordinador
    method agregarBeneficio(unBeneficio) {
        beneficios.add(unBeneficio)
    }
    method valorFinal() = precioBase + beneficios.sum({b=>b.costo()}) 
    method esPackPremium()  
}


class PackNacional inherits PackViaje{
    var provinciaDestino
    const actividades = []
    method provinciaDestino() = provinciaDestino
    method agregarActividad(unaActividad) {
      actividades.add(unaActividad)
    }
    override method esPackPremium()= duracionDias > 10 and coordinador.esAltamenteCalificado()
}

class PackInternacional inherits PackViaje{
    var paisDestino
    var cantidadEscalas
    var lugarInteres = false
    method paisDestino() = paisDestino 
    method cantidadEscalas() = cantidadEscalas 
    method cambiarALugarInteres() {
        lugarInteres = true
    } 
    method esLugarDeInteres() = lugarInteres  

    override method valorFinal() = super() * 1.2
    override method esPackPremium()= self.esLugarDeInteres() and duracionDias>20 and cantidadEscalas==0
    

}
class PackProvincial inherits PackNacional{
    var cantidadCiudadesAVisitar
    method cantidadCiudadesAVisitar() =cantidadCiudadesAVisitar 
    method cantidadBeneficiosVigentes()= beneficios.count({b=>b.estaVigente()})
    override method esPackPremium()= actividades.size()>=4 and cantidadCiudadesAVisitar > 5 and self.cantidadBeneficiosVigentes() >= 3
    override method valorFinal()= if(self.esPackPremium()) super() * 1.05 else super()
}

class Coordinador{
    var cantidadViajes
    var estaMotivado
    var aniosExperiencia
    var rol 
    const roles = [Guia,AsistenteLogistico,Acompaniante]
    method cantidadViajes() = cantidadViajes
    method aniosExperiencia() = aniosExperiencia  
    method estaMotivado() = estaMotivado
    method motivar() {
      estaMotivado = true
    }
    method desmotivar() {
      estaMotivado = false
    }

    method cambiarRol(unNuevoRol) {
     if(unNuevoRol==Guia || unNuevoRol ==AsistenteLogistico || unNuevoRol ==Acompaniante)
        rol = unNuevoRol
    else 
        throw new Exception(message = "No es un Rol valido")
    }
    method esAltamenteCalificado()= self.cantidadViajes()>20 
    
}
class Guia inherits Coordinador {
    override method esAltamenteCalificado()= super() and self.estaMotivado()
}

class AsistenteLogistico inherits Coordinador {
    override method esAltamenteCalificado() = super() and aniosExperiencia>=3

}

class Acompaniante inherits Coordinador {
    

}
class Beneficio{
    var tipo
    var costo
    var estaVigente
    method tipo() = tipo 
    method costo() = costo 
    method estaVigente() = estaVigente 
    method cambiarVigencia(unTipoDeVigencia) {
      estaVigente = unTipoDeVigencia
    }
}



