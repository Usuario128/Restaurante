//
//  RegistroEmpleadoView.swift
//  Restaurante
//
//  Creado el 10/11/25
//

import SwiftUI

struct RegistroEmpleadoView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var storage = UserStorage.shared

    @State private var nombre = ""
    @State private var email = ""
    @State private var telefono = ""
    @State private var direccion = ""
    @State private var puesto: Rol = .empleado
    @State private var password = ""
    @State private var confirmarPassword = ""
    @State private var aceptaTerminos = false
    @State private var imagen: UIImage? = nil
    @State private var mostrarSelectorImagen = false

    @State private var mensajeError: String?
    @State private var mostrarAlerta = false
    @State private var registroExitoso = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Registro de Empleados")
                .font(.largeTitle)
                .bold()
                .padding(.top, 30)

            Text("Complete el formulario para registrar un nuevo empleado")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    campoTexto("Nombre Completo", text: $nombre)
                    campoTexto("Email", text: $email, tipo: .emailAddress)
                    campoTexto("Teléfono", text: $telefono, tipo: .numberPad)
                    campoTexto("Dirección", text: $direccion)

                    // Rol (Puesto)
                    VStack(alignment: .leading) {
                        Text("Puesto:")
                            .font(.headline)
                        Picker("Puesto", selection: $puesto) {
                            Text("Administrador").tag(Rol.administrador)
                            Text("Gerente").tag(Rol.gerente)
                            Text("Empleado").tag(Rol.empleado)
                            Text("Cliente").tag(Rol.cliente)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }

                    // 🔐 Campo de contraseña sin sugerencias ni protección de texto
                    SecureField("Contraseña", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .autocorrectionDisabled(true)
                        .textContentType(.none)

                    SecureField("Confirmar Contraseña", text: $confirmarPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .autocorrectionDisabled(true)
                        .textContentType(.none)

                    // Imagen opcional
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Imagen del Empleado (opcional):")
                            .font(.headline)
                        if let imagen = imagen {
                            Image(uiImage: imagen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        Button("Seleccionar Imagen") {
                            mostrarSelectorImagen = true
                        }
                        .buttonStyle(.bordered)
                    }

                    // Términos y condiciones
                    Toggle(isOn: $aceptaTerminos) {
                        Text("Acepto los términos y condiciones")
                    }

                    if let error = mensajeError {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.callout)
                            .multilineTextAlignment(.center)
                    }

                    // Botones de acción
                    HStack {
                        Button("Cancelar") {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .buttonStyle(.bordered)

                        Button("Registrar") {
                            registrarUsuario()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding(.top, 10)
                }
                .padding(.horizontal)
            }
        }
        .sheet(isPresented: $mostrarSelectorImagen) {
            ImagePicker(imagenSeleccionada: $imagen)
        }
        .alert(isPresented: $mostrarAlerta) {
            if registroExitoso {
                return Alert(
                    title: Text("Registro Exitoso"),
                    message: Text("El empleado fue registrado correctamente."),
                    dismissButton: .default(Text("Aceptar")) {
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            } else {
                return Alert(title: Text("Error"), message: Text(mensajeError ?? ""), dismissButton: .default(Text("Aceptar")))
            }
        }
        .navigationBarHidden(true)
    }

    // MARK: - Componentes reutilizables
    private func campoTexto(_ titulo: String, text: Binding<String>, tipo: UIKeyboardType = .default) -> some View {
        VStack(alignment: .leading) {
            Text(titulo)
                .font(.headline)
            
            TextField(titulo, text: Binding(
                get: { text.wrappedValue },
                set: { newValue in
                    if titulo.lowercased() == "email" {
                        text.wrappedValue = newValue.lowercased()   // 👈 fuerza a minúsculas
                    } else {
                        text.wrappedValue = newValue
                    }
                }
            ))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(tipo)
            .autocapitalization(.none)          // evita mayúsculas automáticas
            .autocorrectionDisabled(true)
        }
    }

    // MARK: - Lógica de validación y guardado
    private func registrarUsuario() {
        // Validaciones
        guard !nombre.isEmpty, !email.isEmpty, !telefono.isEmpty, !direccion.isEmpty, !password.isEmpty, !confirmarPassword.isEmpty else {
            mensajeError = "Todos los campos son obligatorios."
            mostrarAlerta = true
            return
        }

        guard email.contains("@"), email.contains(".") else {
            mensajeError = "Formato de correo electrónico no válido."
            mostrarAlerta = true
            return
        }

        guard telefono.count == 10, telefono.allSatisfy(\.isNumber) else {
            mensajeError = "El teléfono debe tener exactamente 10 dígitos."
            mostrarAlerta = true
            return
        }

        guard password == confirmarPassword else {
            mensajeError = "Las contraseñas no coinciden."
            mostrarAlerta = true
            return
        }

        guard password.count >= 8, password.contains(where: \.isLetter), password.contains(where: \.isNumber) else {
            mensajeError = "La contraseña debe tener al menos 8 caracteres con letras y números."
            mostrarAlerta = true
            return
        }

        guard aceptaTerminos else {
            mensajeError = "Debe aceptar los términos y condiciones."
            mostrarAlerta = true
            return
        }

        // Verificar duplicado
        if storage.usuarios.contains(where: { $0.email.lowercased() == email.lowercased() }) {
            mensajeError = "El correo electrónico ya está registrado."
            mostrarAlerta = true
            return
        }

        // Crear objeto usuario
        let nuevoUsuario = Usuario(
            nombre: nombre,
            email: email,
            telefono: telefono,
            direccion: direccion,
            password: password,
            rol: puesto,
            activo: true,
            imagenData: imagen?.jpegData(compressionQuality: 0.8)
        )

        if let error = storage.agregarUsuario(nuevoUsuario) {
            mensajeError = error
            mostrarAlerta = true
        } else {
            registroExitoso = true
            mostrarAlerta = true
        }
    }
}

// MARK: - Selector de Imagen
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var imagenSeleccionada: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let imagen = info[.originalImage] as? UIImage {
                parent.imagenSeleccionada = imagen
            }
            picker.dismiss(animated: true)
        }
    }
}

#Preview {
    RegistroEmpleadoView()
}
