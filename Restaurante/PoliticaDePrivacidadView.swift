//
//  PoliticaDePrivacidadView.swift
//  Restaurante
//
//  Created by win603 on 07/11/25.
//

import SwiftUI

struct PoliticaDePrivacidadView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Encabezado
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Políticas de Privacidad")
                            .font(.largeTitle)
                            .bold()
                        Text("Obtenga la información sobre nuestras políticas de privacidad")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top)
                    
                    // Secciones
                    PoliticaSection(
                        titulo: "1. Información que Recopilamos",
                        contenido: """
                        Recopilamos información personal cuando te registras en nuestra plataforma, realizas una reserva o interactúas con nuestro sistema. La información que recopilamos puede incluir:
                        • Datos de contacto: Nombre, dirección de correo electrónico, número de teléfono.
                        • Información de la reserva: Fecha, hora, número de personas y detalles de la mesa reservada.
                        • Comentarios y valoraciones: Información que decides proporcionarnos sobre tu experiencia en el restaurante.
                        • Información de pago: Si realizas pagos a través de nuestra plataforma, recopilamos la información relacionada con la transacción a través de un procesador de pagos externo.
                        """
                    )
                    
                    PoliticaSection(
                        titulo: "2. Uso de la Información",
                        contenido: """
                        La información recopilada se utiliza para:
                        • Gestionar tus reservas: Confirmar, modificar o cancelar tus reservas.
                        • Proporcionar una mejor experiencia: Mejorar el servicio ofrecido, gestionar tus comentarios y sugerencias.
                        • Comunicarnos contigo: Enviar confirmaciones de reservas, actualizaciones y promociones.
                        • Cumplir con las obligaciones legales: Gestionar registros y transacciones según las leyes aplicables.
                        """
                    )
                    
                    PoliticaSection(
                        titulo: "3. Protección de la Información",
                        contenido: """
                        Implementamos medidas de seguridad para proteger tu información personal, pero debes tener en cuenta que ninguna transmisión de datos por Internet es 100% segura. Utilizamos protocolos de cifrado para proteger los datos sensibles durante la transmisión.
                        """
                    )
                    
                    PoliticaSection(
                        titulo: "4. Compartir Información con Terceros",
                        contenido: """
                        No vendemos, alquilamos ni compartimos tu información personal con terceros, excepto en los siguientes casos:
                        • Proveedores de servicios: Contratamos a terceros para procesar pagos y gestionar algunas funciones del sistema.
                        • Cumplimiento legal: Podemos divulgar tu información si así lo requiere la ley o una autoridad gubernamental.
                        """
                    )
                    
                    PoliticaSection(
                        titulo: "5. Derechos sobre tu Información",
                        contenido: """
                        Tienes derecho a:
                        • Acceder, corregir o eliminar tu información personal.
                        • Optar por no recibir comunicaciones promocionales o de marketing.
                        
                        Si deseas ejercer estos derechos, contáctanos a través de marcelo.neri@iest.edu.mx.
                        """
                    )
                    
                    PoliticaSection(
                        titulo: "6. Cookies y Tecnología Similar",
                        contenido: """
                        Utilizamos cookies y tecnologías similares para mejorar tu experiencia, personalizar el contenido y analizar el tráfico. Puedes desactivar las cookies en tu navegador, pero algunas funcionalidades del sistema pueden verse afectadas.
                        """
                    )
                    
                    PoliticaSection(
                        titulo: "7. Cambios en esta Política",
                        contenido: """
                        Nos reservamos el derecho de actualizar o modificar esta política de privacidad en cualquier momento. Te notificaremos sobre cualquier cambio importante mediante un aviso en el sitio web.
                        """
                    )
                    
                    // Footer
                    VStack {
                        Divider()
                        Text("© 2024 ReservaMesa. Todos los derechos reservados.")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 20)
                }
                .padding(.horizontal)
            }
            
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PoliticaSection: View {
    let titulo: String
    let contenido: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.headline)
                .foregroundColor(.primary)
            Text(contenido)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
    }
}

#Preview {
    PoliticaDePrivacidadView()
}
