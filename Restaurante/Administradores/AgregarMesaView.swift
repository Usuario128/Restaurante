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
                Section(NSLocalizedString("mesa_datos_seccion", comment: "Título de la sección de datos de la mesa")) {
                    TextField(NSLocalizedString("mesa_numero_placeholder", comment: "Placeholder del número de mesa"), text: $numero)
                        .keyboardType(.numberPad)
                    TextField(NSLocalizedString("mesa_capacidad_placeholder", comment: "Placeholder de capacidad de mesa"), text: $capacidad)
                        .keyboardType(.numberPad)
                }
                
                if let msg = mensajeError {
                    Section {
                        Text(msg)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle(NSLocalizedString("mesa_titulo", comment: "Título de la vista de nueva mesa"))
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(NSLocalizedString("mesa_boton_guardar", comment: "Botón Guardar")) {
                        guardarMesa()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button(NSLocalizedString("mesa_boton_cancelar", comment: "Botón Cancelar")) { dismiss() }
                }
            }
        }
    }
    
    private func guardarMesa() {
        guard let num = Int(numero), num > 0 else {
            mensajeError = NSLocalizedString("mesa_error_numero", comment: "Error número de mesa inválido")
            return
        }
        guard let cap = Int(capacidad), cap > 0 else {
            mensajeError = NSLocalizedString("mesa_error_capacidad", comment: "Error capacidad inválida")
            return
        }
        
        if mesas.contains(where: { $0.numero == num }) {
            mensajeError = NSLocalizedString("mesa_error_existente", comment: "Error mesa ya existente")
            return
        }
        
        let nuevaMesa = Mesa(numero: num, capacidad: cap, disponible: true)
        mesas.append(nuevaMesa)
        StorageMesas.shared.guardarMesas(mesas)
        dismiss()
    }
}

