//  MenuView.swift
//  Restaurante
//
//  Created by win603 on 10/11/25.
//

import SwiftUI

struct MenuView: View {
    @State private var menuItems: [Platillo] = StorageMenu.shared.obtenerMenu()
    @State private var mostrarAgregar = false
    
    private let categorias: [Categoria: String] = [
        .entrada: "Entradas",
        .fuerte: "Platos Fuertes",
        .postre: "Postres",
        .bebida: "Bebidas"
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    ForEach(Categoria.allCases, id: \.self) { categoria in
                        // Asignamos el array primero (no usar `if let` con filter)
                        let platillos = menuItems.filter { $0.categoria == categoria }
                        if !platillos.isEmpty {
                            Text(categorias[categoria] ?? "")
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)
                            
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)], spacing: 16) {
                                ForEach(platillos) { platillo in
                                    PlatilloCard(platillo: platillo, onDelete: eliminarPlatillo, onEdit: editarPlatillo)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    if menuItems.isEmpty {
                        Text("No hay platillos en el menú actualmente.")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Menú del Restaurante")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { mostrarAgregar.toggle() }) {
                        Label("Agregar", systemImage: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $mostrarAgregar, onDismiss: {
                // recargar por si se agregó un platillo
                menuItems = StorageMenu.shared.obtenerMenu()
            }) {
                AgregarPlatilloView { nuevo in
                    menuItems.append(nuevo)
                    StorageMenu.shared.guardarMenu(menuItems)
                }
            }
            .onAppear {
                // asegurar que los datos estén actualizados al mostrar la vista
                menuItems = StorageMenu.shared.obtenerMenu()
            }
        }
    }
    
    private func eliminarPlatillo(_ platillo: Platillo) {
        withAnimation {
            menuItems.removeAll { $0.id == platillo.id }
            StorageMenu.shared.guardarMenu(menuItems)
        }
    }
    
    private func editarPlatillo(_ platilloEditado: Platillo) {
        if let index = menuItems.firstIndex(where: { $0.id == platilloEditado.id }) {
            menuItems[index] = platilloEditado
            StorageMenu.shared.guardarMenu(menuItems)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        // Añadir datos de ejemplo para la preview
        let sample = [
            Platillo(nombre: "Sopa de tortilla", descripcion: "Con pollo y aguacate", precio: 65.0, categoria: .entrada, imagenData: nil),
            Platillo(nombre: "Enchiladas verdes", descripcion: "Rellenas de pollo", precio: 120.0, categoria: .fuerte, imagenData: nil),
            Platillo(nombre: "Pastel de chocolate", descripcion: "Con cobertura de ganache", precio: 55.0, categoria: .postre, imagenData: nil),
            Platillo(nombre: "Agua de jamaica", descripcion: "Refrescante", precio: 25.0, categoria: .bebida, imagenData: nil)
        ]
        StorageMenu.shared.guardarMenu(sample)
        return MenuView()
    }
}
