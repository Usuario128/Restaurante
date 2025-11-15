//  RegistroView.swift
//  Restaurante

import SwiftUI

struct RegistroView: View {
    @StateObject private var storage = UserStorage.shared
    
    @State private var nombre = ""
    @State private var email = ""
    @State private var telefono = ""
    @State private var direccion = ""
    @State private var password = ""
    @State private var confirmarPassword = ""
    @State private var termsAccepted = false
    @State private var imagen: UIImage?
    @State private var errorMessage: String?
    
    @State private var mostrarImagePicker = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Registro")
                        .font(.largeTitle)
                        .bold()
                    
                    Group {
                        TextField("Nombre", text: $nombre)
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        TextField("Teléfono", text: $telefono)
                            .keyboardType(.numberPad)
                        TextField("Dirección", text: $direccion)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    
                    SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    SecureField("Confirmar Contraseña", text: $confirmarPassword)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    HStack {
                        Text("Subir Imagen:")
                        Spacer()
                        Button(action: { mostrarImagePicker = true }) {
                            if let imagen = imagen {
                                Image(uiImage: imagen)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "photo")
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Toggle("Acepto los términos y condiciones", isOn: $termsAccepted)
                        .padding(.horizontal)
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    
                    Button("Registrarme") {
                        registrarUsuario()
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                .padding()
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $mostrarImagePicker) {
                ImagePicker(imagenSeleccionada: $imagen)
            }
        }
    }
    
    func registrarUsuario() {
        errorMessage = nil
        
        guard !nombre.isEmpty, !email.isEmpty, !telefono.isEmpty, !direccion.isEmpty,
              !password.isEmpty, !confirmarPassword.isEmpty, termsAccepted else {
            errorMessage = "Todos los campos son obligatorios y debe aceptar los términos."
            return
        }
        guard email.contains("@") else {
            errorMessage = "Formato de email no válido."
            return
        }
        guard telefono.count == 10, Int(telefono) != nil else {
            errorMessage = "El teléfono debe contener exactamente 10 dígitos."
            return
        }
        guard password.count >= 8,
              password.rangeOfCharacter(from: .letters) != nil,
              password.rangeOfCharacter(from: .decimalDigits) != nil else {
            errorMessage = "La contraseña debe tener al menos 8 caracteres, incluir letras y números."
            return
        }
        guard password == confirmarPassword else {
            errorMessage = "Las contraseñas no coinciden."
            return
        }
        
        let imagenData = imagen?.jpegData(compressionQuality: 0.8)
        
        let usuario = Usuario(
            nombre: nombre,
            email: email,
            telefono: telefono,
            direccion: direccion,
            password: password,
            rol: .empleado,
            imagenData: imagenData
        )
        
        if let error = storage.agregarUsuario(usuario) {
            errorMessage = error
        }
    }
}
