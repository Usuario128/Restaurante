//
//  EditarPlatilloView.swift
//  Restaurante
//

import SwiftUI

struct EditarPlatilloView: View {
    @Environment(\.dismiss) var dismiss
    @State private var platillo: Platillo
    @State private var imagen: UIImage? = nil
    @State private var mostrarSelector = false
    
    var onGuardar: (Platillo) -> Void
    
    init(platillo: Platillo, onGuardar: @escaping (Platillo) -> Void) {
        _platillo = State(initialValue: platillo)
        self.onGuardar = onGuardar
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                            .font(.title2)
                    }
                    
                    Spacer()
                    
                    Text("Editar Platillo")
                        .font(.headline)
                    
                    Spacer()
                    
                    Button(action: {
                        if let nueva = imagen {
                            platillo.imagenData = nueva.jpegData(compressionQuality: 0.8)
                        }
                        onGuardar(platillo)
                        dismiss()
                    }) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.title2)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                
                // ✅ Contenido principal
                Form {
                    Section("Información") {
                        TextField("Nombre", text: $platillo.nombre)
                        TextField("Descripción", text: $platillo.descripcion)
                        TextField("Precio", value: $platillo.precio, format: .number)
                        Picker("Categoría", selection: $platillo.categoria) {
                            ForEach(Categoria.allCases, id: \.self) {
                                Text($0.rawValue.capitalized)
                            }
                        }
                    }
                    
                    Section("Imagen") {
                        if let data = imagen?.jpegData(compressionQuality: 0.8) ?? platillo.imagenData,
                           let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        Button("Cambiar imagen") { mostrarSelector.toggle() }
                    }
                }
            }
            .sheet(isPresented: $mostrarSelector) {
                ImagePicker(imagenSeleccionada: $imagen)
            }
            .navigationBarHidden(true) // ✅ Oculta barra nativa
        }
    }
}
