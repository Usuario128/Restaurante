import SwiftUI

struct VisualizarUsuariosView: View {
    @StateObject private var storage = UserStorage.shared
    @State private var busqueda = ""
    @State private var mostrarAlertaEliminacion = false
    @State private var usuarioAEliminar: Usuario?
    @State private var mostrarRegistro = false
    @State private var selectedUserID: UUID? = nil

    private var roles: [Rol] {
        [.administrador, .gerente, .empleado, .cliente]
    }

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
                Text(NSLocalizedString("usuarios_registrados", comment: ""))
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

                HStack {
                    TextField(NSLocalizedString("buscar_por_nombre", comment: ""), text: $busqueda)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }

                ScrollView {
                    if usuariosFiltrados.isEmpty {
                        Text(String(format: NSLocalizedString("no_resultados", comment: ""), busqueda))
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ForEach(roles, id: \.self) { rol in
                            let usuariosPorRol = usuariosFiltrados.filter { $0.rol == rol }
                            if !usuariosPorRol.isEmpty {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(NSLocalizedString("rol_\(rol.rawValue)", comment: ""))
                                        .font(.title2)
                                        .bold()
                                        .padding(.horizontal)

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
                                                Text(NSLocalizedString("rol_\(usuario.rol.rawValue)", comment: ""))
                                                    .font(.caption)
                                                    .padding(6)
                                                    .background(Color.blue.opacity(0.2))
                                                    .cornerRadius(6)
                                            }

                                            HStack(spacing: 15) {
                                                NavigationLink(
                                                    destination: PerfilUsuarioView(usuario: usuario),
                                                    tag: usuario.id,
                                                    selection: $selectedUserID
                                                ) {
                                                    Text(NSLocalizedString("ver_perfil", comment: ""))
                                                        .foregroundColor(.blue)
                                                }
                                                .simultaneousGesture(TapGesture().onEnded {
                                                    selectedUserID = usuario.id
                                                })
                                                .buttonStyle(PlainButtonStyle())

                                                Button(NSLocalizedString("eliminar", comment: "")) {
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

                HStack {
                    Button(NSLocalizedString("registrar_nuevo_usuario", comment: "")) {
                        mostrarRegistro = true
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
            .sheet(isPresented: $mostrarRegistro) {
                RegistroEmpleadoView()
            }
            .alert(
                NSLocalizedString("alerta_eliminar_usuario", comment: ""),
                isPresented: $mostrarAlertaEliminacion,
                actions: {
                    Button(NSLocalizedString("cancelar", comment: ""), role: .cancel) {}
                    Button(NSLocalizedString("confirmar_eliminar", comment: ""), role: .destructive) {
                        if let usuario = usuarioAEliminar {
                            eliminarUsuario(usuario)
                        }
                    }
                },
                message: {
                    Text(usuarioAEliminar?.nombre ?? "")
                }
            )
            .navigationBarHidden(true)
        }
    }

    private func eliminarUsuario(_ usuario: Usuario) {
        storage.usuarios.removeAll { $0.id == usuario.id }
        if let encoded = try? JSONEncoder().encode(storage.usuarios) {
            UserDefaults.standard.set(encoded, forKey: "usuarios")
        }
    }
}

