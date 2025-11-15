//
//  Usuario.swift
//  Restaurante
//
//  Created by win603 on 07/11/25.
//

import SwiftUI

enum Rol: String, Codable {
    case cliente
    case empleado
    case gerente
    case administrador
}

class Usuario: Identifiable, Codable {
    var id = UUID()
    var nombre: String
    var email: String
    var telefono: String
    var direccion: String
    var password: String
    var rol: Rol
    var activo: Bool
    var imagenData: Data?

    init(nombre: String, email: String, telefono: String, direccion: String, password: String, rol: Rol = .cliente, activo: Bool = true, imagenData: Data? = nil) {
        self.nombre = nombre
        self.email = email
        self.telefono = telefono
        self.direccion = direccion
        self.password = password
        self.rol = rol
        self.activo = activo
        self.imagenData = imagenData
    }
}
