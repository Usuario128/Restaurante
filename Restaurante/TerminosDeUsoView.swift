//
//  TerminosDeUsoView.swift
//  Restaurante
//
//  Created by win603 on 07/11/25.
//

import SwiftUI

struct TerminosDeUsoView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Encabezado
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Términos de Uso")
                            .font(.largeTitle)
                            .bold()
                        Text("Obtenga la información sobre las condiciones por el uso del servicio")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top)
                    
                    // Secciones
                    TerminoSection(
                        titulo: "1. Acceso al Sistema",
                        contenido: """
                        El acceso al sistema de reservas está permitido exclusivamente para personas mayores de 18 años. Al utilizar nuestro sistema, confirmas que tienes la edad legal para hacerlo.
                        """
                    )
                    
                    TerminoSection(
                        titulo: "2. Responsabilidad del Usuario",
                        contenido: """
                        Al utilizar nuestro sistema de reservas, te comprometes a:
                        • Proporcionar información veraz y precisa en tu registro y reservas.
                        • Mantener la confidencialidad de tu cuenta de usuario y contraseña.
                        • No utilizar el sistema para fines ilegales o fraudulentos.
                        • No realizar reservas múltiples para el mismo evento sin la intención de asistir.
                        """
                    )
                    
                    TerminoSection(
                        titulo: "3. Uso del Sistema de Reservas",
                        contenido: """
                        El sistema de reservas está destinado únicamente para realizar reservas de mesas en [Nombre del Restaurante]. No está permitido utilizar la plataforma para realizar reservas fraudulentas, invasivas o no autorizadas.
                        """
                    )
                    
                    TerminoSection(
                        titulo: "4. Política de Cancelación y Modificación de Reservas",
                        contenido: """
                        Puedes modificar o cancelar tus reservas a través del sistema en cualquier momento, dentro de los límites establecidos. Las reservas canceladas dentro de un plazo mínimo pueden estar sujetas a cargos, según las políticas del restaurante.
                        """
                    )
                    
                    TerminoSection(
                        titulo: "5. Comentarios y Valoraciones",
                        contenido: """
                        Los usuarios pueden dejar comentarios y valoraciones sobre su experiencia en el restaurante. Aceptas que dichos comentarios pueden ser publicados en nuestro sitio web y ser utilizados para mejorar nuestros servicios.
                        """
                    )
                    
                    TerminoSection(
                        titulo: "6. Propiedad Intelectual",
                        contenido: """
                        Todos los derechos de propiedad intelectual sobre el contenido del sitio web son propiedad de [Nombre del Restaurante] o de sus licenciantes. Queda prohibida la reproducción, distribución o modificación de dicho contenido sin consentimiento previo.
                        """
                    )
                    
                    TerminoSection(
                        titulo: "7. Exoneración de Responsabilidad",
                        contenido: """
                        El restaurante no se hace responsable de:
                        • Cualquier error o inexactitud en la información proporcionada por los usuarios.
                        • Cualquier daño o pérdida derivada del uso del sistema de reservas o del acceso al sitio web.
                        """
                    )
                    
                    TerminoSection(
                        titulo: "8. Modificación de los Términos",
                        contenido: """
                        Nos reservamos el derecho de modificar estos Términos de Uso en cualquier momento. Cualquier cambio será publicado en esta página con la fecha de actualización.
                        """
                    )
                    
                    TerminoSection(
                        titulo: "9. Ley Aplicable",
                        contenido: """
                        Estos Términos de Uso se regirán e interpretarán de acuerdo con las leyes del país en el que opera el restaurante.
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

struct TerminoSection: View {
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
    TerminosDeUsoView()
}
