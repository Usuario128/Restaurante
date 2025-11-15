//
//  CuentaView.swift
//  Restaurante
//
//  Created by win603 on 12/11/25.
//

import SwiftUI

struct CuentaView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var mesas: [Mesa]
    var mesa: Mesa
    
    var body: some View {
        VStack {
            Text("Cuenta Mesa \(mesa.numero)")
                .font(.largeTitle)
                .padding(.top)
            
            if let pedidos = mesas.first(where: { $0.id == mesa.id })?.pedidos, !pedidos.isEmpty {
                List {
                    ForEach(pedidos) { platillo in
                        HStack {
                            Text(platillo.nombre)
                            Spacer()
                            Text(String(format: "$%.2f", platillo.precio))
                                .bold()
                        }
                    }
                    
                    HStack {
                        Text("TOTAL")
                            .font(.title2)
                        Spacer()
                        Text(String(format: "$%.2f", mesa.totalCuenta))
                            .font(.title2)
                            .bold()
                    }
                }
            } else {
                Text("No hay pedidos registrados.")
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            Button("Cerrar cuenta") {
                if let index = mesas.firstIndex(where: { $0.id == mesa.id }) {
                    mesas[index].pedidos.removeAll()
                    mesas[index].reservacion = nil
                    mesas[index].disponible = true
                    StorageMesas.shared.guardarMesas(mesas)
                    dismiss()
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom)
        }
        .padding()
    }
}
