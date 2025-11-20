//
//  AgregarPlatilloView.swift
//  Restaurante
//

import SwiftUI

struct AgregarPlatilloView: View {
    @Environment(\.dismiss) var dismiss
    @State private var nombre = ""
    @State private var descripcion = ""
    @State private var precio = ""
    @State private var categoria: Categoria = .entrada
    @State private var imagen: UIImage? = nil
    @State private var mostrarSelector = false
    
    var onGuardar: (Platillo) -> Void
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                // ===== Barra Superior / Top Bar =====
                HStack {
                    // Botón cerrar / Close button
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                            .font(.title2)
                    }
                    
                    Spacer()
                    
                    // Título / Title
                    Text("Agregar Platillo / Add Dish") // Español / Inglés
                        .font(.headline)
                    
                    Spacer()
                    
                    // Botón guardar / Save button
                    Button(action: {
                        guard let precioDouble = Double(precio) else { return }
                        let nuevo = Platillo(
                            nombre: nombre,
                            descripcion: descripcion,
                            precio: precioDouble,
                            categoria: categoria,
                            imagenData: imagen?.jpegData(compressionQuality: 0.8)
                        )
                        onGuardar(nuevo)
                        dismiss()
                    }) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.title2)
                    }
                    .disabled(nombre.isEmpty || precio.isEmpty)
                }
                .padding()
                .background(Color(.systemGray6))
                
                // ===== Contenido del formulario / Form Content =====
                Form {
                    
                    // Sección Información / Information Section
                    Section(header: Text("Información del platillo / Dish Information")) {
                        TextField("Nombre / Name", text: $nombre)
                        TextField("Descripción / Description", text: $descripcion)
                        TextField("Precio / Price", text: $precio)
                            .keyboardType(.decimalPad)
                        
                        Picker("Categoría / Category", selection: $categoria) {
                            ForEach(Categoria.allCases, id: \.self) { cat in
                                Text(cat.rawValue.capitalized) // Se pueden traducir con Localizable si se desea
                            }
                        }
                    }
                    
                    // Sección Imagen / Image Section
                    Section(header: Text("Imagen / Image")) {
                        if let imagen = imagen {
                            Image(uiImage: imagen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        Button("Seleccionar imagen / Select Image") { mostrarSelector.toggle() }
                    }
                }
            }
            .sheet(isPresented: $mostrarSelector) {
                ImagePicker(imagenSeleccionada: $imagen)
            }
            .navigationBarHidden(true) // Oculta la barra de navegación nativa / Hide native navigation bar
        }
    }
}

