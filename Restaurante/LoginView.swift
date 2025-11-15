//
//  LoginView.swift
//  Restaurante
//
//  Created by win603 on 07/11/25.
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
        NavigationView {
            VStack(spacing: 20) {
                Text("Iniciar Sesión")
                    .font(.largeTitle)
                    .bold()
                
                TextField("Ingresa tu email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                SecureField("Ingresa tu contraseña", text: $password)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                Toggle("Recordarme", isOn: $rememberMe)
                    .padding(.horizontal)
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                Button("Iniciar Sesión") {
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
    
    func iniciarSesion() {
        errorMessage = nil
        
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Todos los campos son obligatorios."
            return
        }
        
        guard let usuario = storage.usuarios.first(where: { $0.email.lowercased() == email.lowercased() }) else {
            errorMessage = "Credenciales incorrectas."
            return
        }
        
        if usuario.password != password {
            errorMessage = "Credenciales incorrectas."
            return
        }
        
        if !usuario.activo {
            errorMessage = "Tu cuenta está inactiva. Contacta al administrador."
            return
        }
        
        storage.usuarioActual = usuario
        if rememberMe {
            UserDefaults.standard.set(usuario.email, forKey: "usuarioRecordado")
        }
        
        navegarAdmin = true
    }
}
