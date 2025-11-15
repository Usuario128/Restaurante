//  AgregarMesaView.swift
//  Restaurante
//
//  Created by win603 on 12/11/25.
//

import SwiftUI

struct AgregarMesaView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var mesas: [Mesa]
    
    @State private var numero = ""
    @State private var capacidad = ""
    @State private var mensajeError: String? = nil
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Datos de la mesa") {
                    TextField("Número de mesa", text: $numero)
                        .keyboardType(.numberPad)
                    TextField("Capacidad (personas)", text: $capacidad)
                        .keyboardType(.numberPad)
                }
                
                if let msg = mensajeError {
                    Section {
                        Text(msg)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Nueva Mesa")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        guardarMesa()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
        }
    }
    
    private func guardarMesa() {
        guard let num = Int(numero), num > 0 else {
            mensajeError = "Número de mesa inválido."
            return
        }
        guard let cap = Int(capacidad), cap > 0 else {
            mensajeError = "Capacidad inválida."
            return
        }
        
        if mesas.contains(where: { $0.numero == num }) {
            mensajeError = "Ya existe una mesa con ese número."
            return
        }
        
        let nuevaMesa = Mesa(numero: num, capacidad: cap, disponible: true)
        mesas.append(nuevaMesa)
        StorageMesas.shared.guardarMesas(mesas)
        dismiss()
    }
}
