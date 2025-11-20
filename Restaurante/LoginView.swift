//  LoginView.swift
//  Restaurante
//

import SwiftUI

struct LoginView: View {
    @StateObject private var storage = UserStorage.shared
    
    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = false
    @State private var errorMessage: String?
    
    @State private var navegarAdmin = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                // Título
                Text(NSLocalizedString("login_titulo", comment: "Título de la pantalla de login"))
                    .font(.largeTitle)
                    .bold()
                
                // Campo Email
                TextField(NSLocalizedString("login_email_placeholder", comment: "Placeholder del email"), text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                // Campo Contraseña
                SecureField(NSLocalizedString("login_password_placeholder", comment: "Placeholder de la contraseña"), text: $password)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                // Recordarme
                Toggle(NSLocalizedString("login_recordarme", comment: "Toggle Recordarme"), isOn: $rememberMe)
                    .padding(.horizontal)
                
                // Mensaje de error
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                // Botón Iniciar sesión
                Button(NSLocalizedString("login_boton", comment: "Botón de iniciar sesión")) {
                    iniciarSesion()
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            
            // Asegura que la barra de navegación esté visible y el botón de regresar también
            .navigationBarBackButtonHidden(false)
            .navigationBarTitleDisplayMode(.inline)
            
            // Navegación a vista admin
            .fullScreenCover(isPresented: $navegarAdmin) {
                AdministradorView()
            }
            
            .onAppear {
                if let emailRecordado = UserDefaults.standard.string(forKey: "usuarioRecordado"),
                   let usuario = storage.usuarios.first(where: { $0.email.lowercased() == emailRecordado.lowercased() }) {
                    storage.usuarioActual = usuario
                    navegarAdmin = true
                }
            }
        }
    }
    
    // MARK: - Lógica del Login
    func iniciarSesion() {
        errorMessage = nil
        
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = NSLocalizedString("login_error_campos", comment: "Error campos vacíos")
            return
        }
        
        guard let usuario = storage.usuarios.first(where: { $0.email.lowercased() == email.lowercased() }) else {
            errorMessage = NSLocalizedString("login_error_credenciales", comment: "Error credenciales")
            return
        }
        
        if usuario.password != password {
            errorMessage = NSLocalizedString("login_error_credenciales", comment: "Error credenciales")
            return
        }
        
        if !usuario.activo {
            errorMessage = NSLocalizedString("login_error_inactivo", comment: "Error cuenta inactiva")
            return
        }
        
        storage.usuarioActual = usuario
        
        if rememberMe {
            UserDefaults.standard.set(usuario.email, forKey: "usuarioRecordado")
        }
        
        navegarAdmin = true
    }
}

