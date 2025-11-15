//
//  QRUsuarioView.swift
//  Restaurante
//
//  Created by win603 on 14/11/25.
//

import SwiftUI

struct QRUsuarioView: View {
    var usuario: Usuario
    @State private var qrImage: UIImage? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text("QR del Empleado")
                .font(.title.bold())
            
            if let qrImage = qrImage {
                Image(uiImage: qrImage)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
            } else {
                ProgressView("Generando QR...")
            }
        }
        .padding()
        .onAppear {
            generarQR()
        }
    }
    
    /// Generar QR usando API gratuita
    private func generarQR() {
        let texto = """
        EMPLEADO:
        Nombre: \(usuario.nombre)
        Email: \(usuario.email)
        Teléfono: \(usuario.telefono)
        Dirección: \(usuario.direccion)
        Rol: \(usuario.rol.rawValue.uppercased())
        Activo: \(usuario.activo ? "Sí" : "No")
        """

        let encoded = texto.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=\(encoded)"

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let img = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.qrImage = img
                }
            }
        }.resume()
    }
}
