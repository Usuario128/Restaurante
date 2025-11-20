//  DetalleMesaView.swift
//  Restaurante
//  Internacionalizado: inglés/español

import SwiftUI

struct DetalleMesaView: View {
    var mesa: Mesa
    @Binding var mesas: [Mesa]
    @State private var mostrarReservar = false
    @State private var mostrarMenu = false

    // ✅ Encuentra el índice de la mesa activa / Active table index
    private var mesaIndex: Int? {
        mesas.firstIndex(where: { $0.id == mesa.id })
    }

    // ✅ Obtiene la referencia actualizada de la mesa / Current table reference
    private var currentMesa: Mesa {
        mesaIndex != nil ? mesas[mesaIndex!] : mesa
    }

    var body: some View {
        VStack(spacing: 20) {
            // ✅ Título de la mesa / Table title
            Text(String(format: NSLocalizedString("detalle_mesa_titulo", comment: "Table title"), currentMesa.numero))
                .font(.largeTitle)

            // ✅ Información de la reservación / Reservation info
            if let reserva = currentMesa.reservacion {
                VStack(spacing: 6) {
                    Text(String(format: NSLocalizedString("detalle_mesa_reservada_por", comment: "Reserved by"), reserva.nombreCliente))
                    Text(String(format: NSLocalizedString("detalle_mesa_personas", comment: "Number of people"), reserva.numeroPersonas))
                    Text(String(format: NSLocalizedString("detalle_mesa_horario", comment: "Reservation time"), reserva.horario.formatted(date: .omitted, time: .shortened)))
                }
                .padding(.top, 5)
            } else {
                Text(NSLocalizedString("detalle_mesa_sin_reservacion", comment: "No reservation"))
                    .foregroundColor(.secondary)
            }

            // ✅ Cuenta total / Total bill
            Text(String(format: NSLocalizedString("detalle_mesa_cuenta_total", comment: "Total bill"), currentMesa.totalCuenta))
                .font(.title2)
                .bold()
                .padding(.top, 10)

            // ✅ Botones / Buttons
            Button(NSLocalizedString("detalle_mesa_boton_reservar", comment: "Reserve table button")) {
                mostrarReservar = true
            }
            .buttonStyle(.borderedProminent)

            Button(NSLocalizedString("detalle_mesa_boton_ver_pedido", comment: "View/Edit order button")) {
                mostrarMenu = true
            }
            .buttonStyle(.bordered)

            Spacer()
        }
        .padding()
        // ✅ Vista para reservar mesa / Reservation view
        .sheet(isPresented: $mostrarReservar) {
            ReservarMesaView(mesas: $mesas, mesa: mesa)
        }
        // ✅ Vista para agregar o quitar pedidos / Menu edit view
        .sheet(isPresented: $mostrarMenu) {
            MenuPedidoView(mesas: $mesas, mesa: mesa)
        }
    }
}

