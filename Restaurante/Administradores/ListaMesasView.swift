//
//  ListaMesasView.swift
//  Restaurante
//
//  Created by win603 on 12/11/25.
//

import SwiftUI

struct ListaMesasView: View {
    @State private var mesas: [Mesa] = StorageMesas.shared.obtenerMesas()
    @State private var mostrarAgregarMesa = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(mesas) { mesa in
                    NavigationLink(destination: DetalleMesaView(mesa: mesa, mesas: $mesas)) {
                        VStack(alignment: .leading) {
                            Text("Mesa \(mesa.numero)")
                                .font(.headline)
                            Text(mesa.disponible ? "Disponible" : "Ocupada")
                                .foregroundColor(mesa.disponible ? .green : .red)
                            Text("Capacidad: \(mesa.capacidad)")
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete { indexSet in
                    mesas.remove(atOffsets: indexSet)
                    StorageMesas.shared.guardarMesas(mesas)
                }
            }
            .navigationTitle("Mesas disponibles")
            .toolbar {
                Button {
                    mostrarAgregarMesa.toggle()
                } label: {
                    Label("Agregar Mesa", systemImage: "plus")
                }
            }
            .sheet(isPresented: $mostrarAgregarMesa) {
                AgregarMesaView(mesas: $mesas)
            }
        }
    }
}

