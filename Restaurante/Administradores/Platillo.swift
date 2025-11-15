//
//  Platillo.swift
//  Restaurante
//

import Foundation
import SwiftUI

enum Categoria: String, Codable, CaseIterable {
    case entrada
    case fuerte
    case postre
    case bebida
}

struct Platillo: Identifiable, Codable {
    var id = UUID()
    var nombre: String
    var descripcion: String
    var precio: Double
    var categoria: Categoria
    var imagenData: Data?
}
