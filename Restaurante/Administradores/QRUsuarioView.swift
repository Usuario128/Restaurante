//  QRUsuarioView.swift
//  Restaurante
//  Internacionalizado: inglés/español

import SwiftUI

struct QRUsuarioView: View {
    var usuario: Usuario
    @State private var qrImage: UIImage? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            // 🔹 Título
            Text(NSLocalizedString("qr_titulo", comment: "QR title for employee"))
                .font(.title.bold())
            
            // 🔹 Imagen QR
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
                ProgressView(NSLocalizedString("qr_generando", comment: "QR generating progress"))
            }
        }
        .padding()
        .onAppear {
            generarQR()
        }
    }
    
    // 🔹 Función para generar QR usando API gratuita
    private func generarQR() {
        let activoTexto = usuario.activo ? NSLocalizedString("si", comment: "Yes") : NSLocalizedString("no", comment: "No")
        
        let texto = """
        EMPLEADO:
        Nombre: \(usuario.nombre)
        Email: \(usuario.email)
        Teléfono: \(usuario.telefono)
        Dirección: \(usuario.direccion)
        Rol: \(usuario.rol.rawValue.uppercased())
        Activo: \(activoTexto)
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

