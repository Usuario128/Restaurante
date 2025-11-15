//
//  VisualizarUsuariosView.swift
//  Restaurante
//
//  Creado el 10/11/25
//

import SwiftUI

struct VisualizarUsuariosView: View {
    @StateObject private var storage = UserStorage.shared
    @State private var busqueda = ""
    @State private var mostrarAlertaEliminacion = false
    @State private var usuarioAEliminar: Usuario?
    @State private var mostrarRegistro = false   // 👈 Nueva variable para mostrar RegistroEmpleadoView
    
    // Selección para navegación (usamos el UUID del usuario)
    @State private var selectedUserID: UUID? = nil
    
    // Roles disponibles
    private var roles: [Rol] {
        [.administrador, .gerente, .empleado, .cliente]
    }
    
    // Filtrar usuarios según texto de búsqueda
    private var usuariosFiltrados: [Usuario] {
        if busqueda.isEmpty {
            return storage.usuarios
        } else {
            return storage.usuarios.filter { $0.nombre.localizedCaseInsensitiveContains(busqueda) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("Usuarios Registrados")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                
                // Campo de búsqueda
                HStack {
                    TextField("Buscar por nombre...", text: $busqueda)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }
                
                ScrollView {
                    if usuariosFiltrados.isEmpty {
                        Text("No se encontraron resultados para \"\(busqueda)\".")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        // Mostrar agrupado por rol
                        ForEach(roles, id: \.self) { rol in
                            let usuariosPorRol = usuariosFiltrados.filter { $0.rol == rol }
                            if !usuariosPorRol.isEmpty {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(rol.rawValue.capitalized)
                                        .font(.title2)
                                        .bold()
                                        .padding(.horizontal)
                                    
                                    // Lista de usuarios
                                    ForEach(usuariosPorRol) { usuario in
                                        VStack(alignment: .leading, spacing: 6) {
                                            HStack {
                                                VStack(alignment: .leading) {
                                                    Text(usuario.nombre)
                                                        .font(.headline)
                                                    Text(usuario.email)
                                                        .font(.subheadline)
                                                        .foregroundColor(.gray)
                                                }
                                                Spacer()
                                                Text(usuario.rol.rawValue.capitalized)
                                                    .font(.caption)
                                                    .padding(6)
                                                    .background(Color.blue.opacity(0.2))
                                                    .cornerRadius(6)
                                            }
                                            
                                            HStack(spacing: 15) {
                                                // 🔹 Texto "Ver Perfil" clickeable sin fondo
                                                NavigationLink(
                                                    destination: PerfilUsuarioView(usuario: usuario),
                                                    tag: usuario.id,
                                                    selection: $selectedUserID
                                                ) {
                                                    Text("Ver Perfil")
                                                        .foregroundColor(.blue)
                                                }
                                                .simultaneousGesture(TapGesture().onEnded {
                                                    selectedUserID = usuario.id
                                                })
                                                .buttonStyle(PlainButtonStyle())
                                                
                                                
                                                
                                                Button("Eliminar") {
                                                    usuarioAEliminar = usuario
                                                    mostrarAlertaEliminacion = true
                                                }
                                                .foregroundColor(.red)
                                                .buttonStyle(BorderlessButtonStyle())
                                            }
                                            .font(.caption)
                                        }
                                        .padding()
                                        .background(Color(.systemGray6))
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                    }
                                }
                                .padding(.vertical, 5)
                            }
                        }
                    }
                }
                
                // Botones generales
                HStack {
                    // 👇 Botón que abre la vista de registro como sheet
                    Button("Registrar Nuevo Usuario") {
                        mostrarRegistro = true
                    }
                    .buttonStyle(.borderedProminent)
                    
                   
                }
                .padding()
            }
            .sheet(isPresented: $mostrarRegistro) {
                RegistroEmpleadoView()
            }
            .alert("¿Deseas eliminar este usuario?", isPresented: $mostrarAlertaEliminacion, actions: {
                Button("Cancelar", role: .cancel) {}
                Button("Eliminar", role: .destructive) {
                    if let usuario = usuarioAEliminar {
                        eliminarUsuario(usuario)
                    }
                }
            }, message: {
                Text(usuarioAEliminar?.nombre ?? "")
            })
            .navigationBarHidden(true)
        }
    }
    
    // Función para eliminar un usuario
    private func eliminarUsuario(_ usuario: Usuario) {
        storage.usuarios.removeAll { $0.id == usuario.id }
        // Guardar cambios en UserDefaults
        if let encoded = try? JSONEncoder().encode(storage.usuarios) {
            UserDefaults.standard.set(encoded, forKey: "usuarios")
        }
    }
}

#Preview {
    let _ = {
        let storage = UserStorage.shared
        if storage.usuarios.isEmpty {
            storage.usuarios = [
                Usuario(nombre: "Carlos Pérez", email: "carlos@restaurante.com", telefono: "1111111111", direccion: "Oficina", password: "12345678", rol: .administrador),
                Usuario(nombre: "Ana López", email: "ana@restaurante.com", telefono: "2222222222", direccion: "Sucursal A", password: "12345678", rol: .gerente),
                Usuario(nombre: "José Torres", email: "jose@restaurante.com", telefono: "3333333333", direccion: "Sucursal B", password: "12345678", rol: .empleado),
                Usuario(nombre: "Laura Díaz", email: "laura@restaurante.com", telefono: "4444444444", direccion: "Col. Centro", password: "12345678", rol: .cliente)
            ]
        }
    }()
    
    return VisualizarUsuariosView()
}
