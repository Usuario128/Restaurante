//
//  PlatilloCard.swift
//  Restaurante
//

import SwiftUI

struct PlatilloCard: View {
    var platillo: Platillo
    var onDelete: (Platillo) -> Void
    var onEdit: (Platillo) -> Void
    @State private var mostrarEditar = false
    
    var body: some View {
        VStack(spacing: 8) {
            if let data = platillo.imagenData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                Image(systemName: "fork.knife.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .foregroundColor(.gray)
                    .padding(.top, 10)
            }
            
            Text(platillo.nombre)
                .font(.headline)
                .lineLimit(1)
            
            Text(platillo.descripcion)
                .font(.caption)
                .lineLimit(2)
                .foregroundColor(.secondary)
            
            Text(String(format: "$%.2f", platillo.precio))
                .font(.subheadline)
                .bold()
                .padding(.top, 4)
            
            HStack {
                Button("Editar") { mostrarEditar.toggle() }
                    .font(.caption)
                    .padding(6)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
                
                Button("Eliminar") { onDelete(platillo) }
                    .font(.caption)
                    .padding(6)
                    .background(Color.red.opacity(0.2))
                    .cornerRadius(8)
            }
            .padding(.bottom, 6)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
        .sheet(isPresented: $mostrarEditar) {
            EditarPlatilloView(platillo: platillo) { editado in
                onEdit(editado)
            }
        }
    }
}
