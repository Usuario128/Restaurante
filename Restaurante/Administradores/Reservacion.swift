//
//  Reservacion.swift
//  Restaurante
//
//  Created by win603 on 12/11/25.
//

import Foundation

struct Reservacion: Identifiable, Codable {
    var id = UUID()
    var nombreCliente: String
    var numeroPersonas: Int
    var horario: Date
}
