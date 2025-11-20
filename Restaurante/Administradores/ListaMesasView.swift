//  ListaMesasView.swift
//  Restaurante
//  Internacionalizado: inglés/español

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
                            Text("\(NSLocalizedString("mesa_numero", comment: "Mesa number")) \(mesa.numero)")
                                .font(.headline)
                            Text(mesa.disponible
                                 ? NSLocalizedString("mesa_disponible", comment: "Table available")
                                 : NSLocalizedString("mesa_ocupada", comment: "Table occupied"))
                                .foregroundColor(mesa.disponible ? .green : .red)
                            Text(String(format: NSLocalizedString("mesa_capacidad", comment: "Table capacity"), mesa.capacidad))
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete { indexSet in
                    mesas.remove(atOffsets: indexSet)
                    StorageMesas.shared.guardarMesas(mesas)
                }
            }
            .navigationTitle(NSLocalizedString("lista_mesas_titulo", comment: "Available Tables"))
            .toolbar {
                Button {
                    mostrarAgregarMesa.toggle()
                } label: {
                    Label(NSLocalizedString("boton_agregar_mesa", comment: "Add Table button"), systemImage: "plus")
                }
            }
            .sheet(isPresented: $mostrarAgregarMesa) {
                AgregarMesaView(mesas: $mesas)
            }
        }
    }
}
