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
                TextField(NSLocalizedString("campo_nombre_cliente", comment: ""), text: $nombre)
                TextField(NSLocalizedString("campo_numero_personas", comment: ""), text: $numeroPersonas)
                    .keyboardType(.numberPad)
                DatePicker(NSLocalizedString("campo_horario", comment: ""), selection: $fecha, displayedComponents: .hourAndMinute)
            }
            .navigationTitle(NSLocalizedString("reservar_mesa_titulo", comment: ""))
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(NSLocalizedString("boton_guardar", comment: "")) {
                        if let index = mesas.firstIndex(where: { $0.id == mesa.id }),
                           let num = Int(numeroPersonas), !nombre.isEmpty {
                            mesas[index].reservacion = Reservacion(nombreCliente: nombre, numeroPersonas: num, horario: fecha)
                            mesas[index].disponible = false
                            StorageMesas.shared.guardarMesas(mesas)
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button(NSLocalizedString("boton_cancelar", comment: "")) {
                        dismiss()
                    }
                }
            }
        }
    }
}

