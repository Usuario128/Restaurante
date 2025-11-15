//
//  ReservarMesaView.swift
//  Restaurante
//

import SwiftUI

struct ReservarMesaView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var mesas: [Mesa]
    var mesa: Mesa
    
    @State private var nombre = ""
    @State private var numeroPersonas = ""
    @State private var fecha = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Nombre del cliente", text: $nombre)
                TextField("Número de personas", text: $numeroPersonas)
                    .keyboardType(.numberPad)
                DatePicker("Horario", selection: $fecha, displayedComponents: .hourAndMinute)
            }
            .navigationTitle("Reservar mesa")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        if let index = mesas.firstIndex(where: { $0.id == mesa.id }),
                           let num = Int(numeroPersonas) {
                            mesas[index].reservacion = Reservacion(nombreCliente: nombre, numeroPersonas: num, horario: fecha)
                            mesas[index].disponible = false
                            StorageMesas.shared.guardarMesas(mesas)
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
        }
    }
}

