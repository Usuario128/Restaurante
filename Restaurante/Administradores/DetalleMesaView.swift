//
//  DetalleMesaView.swift
//  Restaurante
//
//  Actualizado para permitir agregar y quitar platillos correctamente.
//

import SwiftUI

struct DetalleMesaView: View {
    var mesa: Mesa
    @Binding var mesas: [Mesa]
    @State private var mostrarReservar = false
    @State private var mostrarMenu = false

    // Encuentra el índice de la mesa activa
    private var mesaIndex: Int? {
        mesas.firstIndex(where: { $0.id == mesa.id })
    }

    // Obtiene la referencia actualizada de la mesa
    private var currentMesa: Mesa {
        mesaIndex != nil ? mesas[mesaIndex!] : mesa
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Mesa \(currentMesa.numero)")
                .font(.largeTitle)

            if let reserva = currentMesa.reservacion {
                VStack(spacing: 6) {
                    Text("Reservada por: \(reserva.nombreCliente)")
                    Text("Personas: \(reserva.numeroPersonas)")
                    Text("Horario: \(reserva.horario.formatted(date: .omitted, time: .shortened))")
                }
                .padding(.top, 5)
            } else {
                Text("Sin reservación")
                    .foregroundColor(.secondary)
            }

            Text(String(format: "Cuenta total: $%.2f", currentMesa.totalCuenta))
                .font(.title2)
                .bold()
                .padding(.top, 10)

            Button("Reservar mesa") {
                mostrarReservar = true
            }
            .buttonStyle(.borderedProminent)

            Button("Ver / Editar Pedido") {
                mostrarMenu = true
            }
            .buttonStyle(.bordered)

            Spacer()
        }
        .padding()
        // Vista para reservar mesa
        .sheet(isPresented: $mostrarReservar) {
            ReservarMesaView(mesas: $mesas, mesa: mesa)
        }
        // Vista para agregar o quitar pedidos
        .sheet(isPresented: $mostrarMenu) {
            MenuPedidoView(mesas: $mesas, mesa: mesa)
        }
    }
}

