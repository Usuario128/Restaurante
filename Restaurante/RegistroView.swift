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
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Título
                    Text("Registro")
                        .font(.largeTitle)
                        .bold()
                    
                    Group {
                        TextField("Nombre", text: $nombre)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                        
                        TextField("Correo electrónico", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                        
                        TextField("Teléfono", text: $telefono)
                            .keyboardType(.numberPad)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                        
                        TextField("Dirección", text: $direccion)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    
                    // Contraseña
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.gray)
                        SecureField("Contraseña", text: $password)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .textContentType(.password)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    
                    // Confirmar contraseña
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.gray)
                        SecureField("Confirmar contraseña", text: $confirmarPassword)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .textContentType(.password)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    
                    // Imagen de perfil
                    HStack {
                        Text("Subir imagen")
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
                    
                    Toggle("Acepto los términos", isOn: $termsAccepted)
                        .padding(.horizontal)
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    
                    Button("Registrarse") {
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
            .navigationBarBackButtonHidden(false)
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $mostrarImagePicker) {
                ImagePicker(imagenSeleccionada: $imagen)
            }
        }
    }
    
    func registrarUsuario() {
        errorMessage = nil
        
        guard !nombre.isEmpty, !email.isEmpty, !telefono.isEmpty, !direccion.isEmpty,
              !password.isEmpty, !confirmarPassword.isEmpty, termsAccepted else {
            errorMessage = "Todos los campos son obligatorios"
            return
        }
        
        guard email.contains("@") else {
            errorMessage = "Correo electrónico no válido"
            return
        }
        
        guard telefono.count == 10, Int(telefono) != nil else {
            errorMessage = "Teléfono inválido"
            return
        }
        
        guard password.count >= 8,
              password.rangeOfCharacter(from: .letters) != nil,
              password.rangeOfCharacter(from: .decimalDigits) != nil else {
            errorMessage = "La contraseña debe tener al menos 8 caracteres, letras y números"
            return
        }
        
        guard password == confirmarPassword else {
            errorMessage = "Las contraseñas no coinciden"
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

