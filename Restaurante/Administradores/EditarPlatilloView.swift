//  EditarPlatilloView.swift
//  Restaurante
//  Internacionalizado: inglés/español

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
                // ✅ Barra superior personalizada / Custom top bar
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                            .font(.title2)
                    }
                    
                    Spacer()
                    
                    Text(NSLocalizedString("editar_platillo_titulo", comment: "Edit Dish title"))
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
                
                // ✅ Contenido principal / Main content
                Form {
                    // Sección de información / Information section
                    Section(NSLocalizedString("editar_platillo_seccion_informacion", comment: "Information section")) {
                        TextField(NSLocalizedString("editar_platillo_nombre", comment: "Dish name"), text: $platillo.nombre)
                        TextField(NSLocalizedString("editar_platillo_descripcion", comment: "Dish description"), text: $platillo.descripcion)
                        TextField(NSLocalizedString("editar_platillo_precio", comment: "Dish price"), value: $platillo.precio, format: .number)
                        
                        Picker(NSLocalizedString("editar_platillo_categoria", comment: "Dish category"), selection: $platillo.categoria) {
                            ForEach(Categoria.allCases, id: \.self) {
                                Text($0.rawValue.capitalized)
                            }
                        }
                    }
                    
                    // Sección de imagen / Image section
                    Section(NSLocalizedString("editar_platillo_seccion_imagen", comment: "Image section")) {
                        if let data = imagen?.jpegData(compressionQuality: 0.8) ?? platillo.imagenData,
                           let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        Button(NSLocalizedString("editar_platillo_cambiar_imagen", comment: "Change image button")) {
                            mostrarSelector.toggle()
                        }
                    }
                }
            }
            .sheet(isPresented: $mostrarSelector) {
                ImagePicker(imagenSeleccionada: $imagen)
            }
            .navigationBarHidden(true) // ✅ Oculta barra nativa / Hide native navigation bar
        }
    }
}

