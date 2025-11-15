//  Mesa.swift
//  Restaurante
//
//  Created by win603 on 12/11/25.
//

import Foundation

struct Mesa: Identifiable, Codable {
    var id: UUID = UUID()
    var numero: Int
    var capacidad: Int = 4               // valor por defecto para compatibilidad
    var disponible: Bool = true
    var reservacion: Reservacion? = nil
    var pedidos: [Platillo] = []        // evita fallas al decodificar

    var totalCuenta: Double {
        pedidos.reduce(0) { $0 + $1.precio }
    }

    init(id: UUID = UUID(),
         numero: Int,
         capacidad: Int = 4,
         disponible: Bool = true,
         reservacion: Reservacion? = nil,
         pedidos: [Platillo] = []) {
        
        self.id = id
        self.numero = numero
        self.capacidad = capacidad
        self.disponible = disponible
        self.reservacion = reservacion
        self.pedidos = pedidos
    }
}
