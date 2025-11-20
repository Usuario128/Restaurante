//  CuentaView.swift
//  Restaurante

import SwiftUI

struct CuentaView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var mesas: [Mesa]
    var mesa: Mesa
    
    var body: some View {
        VStack {
            // ✅ Título de la mesa / Table title
            Text(String(format: NSLocalizedString("cuenta_titulo", comment: "Table account title"), mesa.numero))
                .font(.largeTitle)
                .padding(.top)
            
            // ✅ Lista de pedidos / Orders list
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
                        Text(NSLocalizedString("cuenta_total", comment: "Total label"))
                            .font(.title2)
                        Spacer()
                        Text(String(format: "$%.2f", mesa.totalCuenta))
                            .font(.title2)
                            .bold()
                    }
                }
            } else {
                Text(NSLocalizedString("cuenta_no_pedidos", comment: "No orders text"))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // ✅ Botón cerrar cuenta / Close bill button
            Button(NSLocalizedString("cuenta_boton_cerrar", comment: "Close account button")) {
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

