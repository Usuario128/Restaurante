import SwiftUI

struct AdministradorView: View {
    @StateObject private var storage = UserStorage.shared
    @State private var mostrarLanding = false
    @State private var mostrarUsuarios = false
    @State private var mostrarMenu = false
    @State private var mostrarMesas = false
    @State private var mostrarQR = false   // 👈 NUEVO: mostrar QR

    var usuario: Usuario? {
        storage.usuarioActual
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    
                    // Encabezado
                    Text("Panel de Control")
                        .font(.largeTitle.bold())
                        .padding(.top)
                    
                    Text("Selecciona una opción para gestionar el sistema")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    
                    // IMAGEN DEL USUARIO
                    if let imagenData = usuario?.imagenData,
                       let uiImage = UIImage(data: imagenData) {
                        
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .padding(.top)
                        
                    } else {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 120, height: 120)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            )
                            .padding(.top)
                    }
                    
                    
                    // INFORMACIÓN DEL USUARIO
                    VStack(alignment: .leading, spacing: 10) {
                        HStack { Text("👤 Nombre:").bold(); Text(usuario?.nombre ?? "—") }
                        HStack { Text("✉️ Email:").bold(); Text(usuario?.email ?? "—") }
                        HStack { Text("📞 Teléfono:").bold(); Text(usuario?.telefono ?? "—") }
                        HStack { Text("🏠 Dirección:").bold(); Text(usuario?.direccion ?? "—") }
                        HStack { Text("🧩 Rol:").bold(); Text(usuario?.rol.rawValue.capitalized ?? "—") }
                        HStack { Text("⚙️ Estado:").bold(); Text(usuario?.activo == true ? "Activo" : "Inactivo") }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    
                    // BOTONES DEL PANEL
                    VStack(spacing: 15) {
                        
                        Button("📋 Visualizar Reservas y Mesas") {
                            mostrarMesas = true
                        }
                        .buttonStyle(AdminButtonStyle())
                        
                        Button("👥 Visualizar Usuarios") {
                            mostrarUsuarios = true
                        }
                        .buttonStyle(AdminButtonStyle())
                        
                        Button("🍽️ Visualizar Menús") {
                            mostrarMenu = true
                        }
                        .buttonStyle(AdminButtonStyle())
                        
                        
                    
                        Button("🔳 Generar QR del Empleado") {
                            mostrarQR = true
                        }
                        .buttonStyle(AdminButtonStyle())
                      
                        
                        Button("🚪 Cerrar Sesión") {
                            storage.usuarioActual = nil
                            mostrarLanding = true
                        }
                        .foregroundColor(.red)
                        .padding(.top)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarHidden(true)
            
            
            // MARK: - NAVEGACIONES
            .fullScreenCover(isPresented: $mostrarLanding) {
                LandingPageView()
            }
            .sheet(isPresented: $mostrarUsuarios) {
                VisualizarUsuariosView()
            }
            .sheet(isPresented: $mostrarMenu) {
                MenuView()
            }
            .sheet(isPresented: $mostrarMesas) {
                ListaMesasView()
            }
            
            // 🔳 QR EMPLEADO
            .sheet(isPresented: $mostrarQR) {
                if let u = usuario {
                    QRUsuarioView(usuario: u)    // 👈 AQUI SE INTEGRA
                }
            }
        }
    }
}


// Estilo uniforme para los botones
struct AdminButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue.opacity(configuration.isPressed ? 0.7 : 1))
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(radius: 2)
    }
}

struct AdministradorView_Previews: PreviewProvider {
    static var previews: some View {
        let admin = Usuario(
            nombre: "Admin",
            email: "admin@restaurante.com",
            telefono: "1234567890",
            direccion: "Calle Falsa 123",
            password: "admin123",
            rol: .administrador
        )
        UserStorage.shared.usuarios = [admin]
        UserStorage.shared.usuarioActual = admin
        
        return AdministradorView()
    }
}
