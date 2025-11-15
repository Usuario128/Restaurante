import SwiftUI

class UserStorage: ObservableObject {
    static let shared = UserStorage()
    
    @Published var usuarios: [Usuario] = []
    @Published var usuarioActual: Usuario?

    private init() {
        cargarUsuarios()
        crearAdminPorDefectoSiNoExiste()
    }
    
    func agregarUsuario(_ usuario: Usuario) -> String? {
        if usuarios.contains(where: { $0.email.lowercased() == usuario.email.lowercased() }) {
            return "El correo electrónico ya está registrado."
        }
        usuarios.append(usuario)
        guardarUsuarios()
        usuarioActual = usuario
        return nil
    }
    
    private func guardarUsuarios() {
        if let encoded = try? JSONEncoder().encode(usuarios) {
            UserDefaults.standard.set(encoded, forKey: "usuarios")
        }
    }
    
    private func cargarUsuarios() {
        if let data = UserDefaults.standard.data(forKey: "usuarios"),
           let decoded = try? JSONDecoder().decode([Usuario].self, from: data) {
            usuarios = decoded
        }
    }
    
    private func crearAdminPorDefectoSiNoExiste() {
        // Si no hay ningún administrador, creamos uno
        if !usuarios.contains(where: { $0.rol == .administrador }) {
            let admin = Usuario(
                nombre: "admin",
                email: "admin@gmail.com",
                telefono: "0000000000",
                direccion: "Oficina Principal",
                password: "1234", // Contraseña por defecto
                rol: .administrador
            )
            usuarios.append(admin)
            guardarUsuarios()
        }
    }
}
