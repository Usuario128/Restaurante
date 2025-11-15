//
//  SobreNosotrosView.swift
//  Restaurante
//
//  Created by win603 on 07/11/25.
//

import SwiftUI

struct SobreNosotrosView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Encabezado
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Bienvenido al Sistema de Gestión de Reservas ReservaMesa")
                            .font(.largeTitle)
                            .bold()
                        Text("Reserva tu mesa, consulta el menú y mucho más.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top)
                    
                    // Secciones
                    SobreNosotrosSection(
                        titulo: "Acerca de Nuestro Servicio",
                        contenido: """
                        El sistema de gestión de reservas para el restaurante está diseñado para ofrecer una experiencia eficiente y conveniente tanto para los usuarios como para el personal del restaurante. A través de este sistema, se busca facilitar el proceso de reserva de mesas, consulta del menú y gestión de comentarios.
                        """
                    )
                    
                    SobreNosotrosSection(
                        titulo: "¿Cómo Funciona?",
                        contenido: """
                        Usar nuestro sistema es muy sencillo:
                        • Reserva en línea: Escoge la fecha, hora y número de personas para reservar tu mesa.
                        • Consulta el Menú: Navega por nuestro menú completo para ver nuestras especialidades del día y opciones a la carta.
                        • Gestiona tus reservas: Puedes ver, modificar o cancelar tus reservas en cualquier momento.
                        • Deja comentarios: Al finalizar tu experiencia, puedes dejar un comentario sobre la comida y el servicio.
                        """
                    )
                    
                    SobreNosotrosSection(
                        titulo: "Servicios Disponibles",
                        contenido: """
                        • Reservas en línea: Reserva tu mesa desde cualquier lugar, en cualquier momento.
                        • Menú Interactivo: Consulta nuestro menú digital, con imágenes y descripciones detalladas.
                        • Gestión de Reservas: Accede a tu historial de reservas y realiza cambios o cancelaciones fácilmente.
                        • Comentarios y Valoraciones: Deja tus comentarios sobre el servicio y las opciones gastronómicas.
                        """
                    )
                    
                    SobreNosotrosSection(
                        titulo: "Contacto",
                        contenido: """
                        Para cualquier consulta o si necesitas asistencia, no dudes en contactarnos:
                        • Correo Electrónico: marcelo.neri@iest.edu.mx
                        • Teléfono: 845 103 3478
                        • Dirección: Calle Ejemplo 123, Ciudad, País
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

struct SobreNosotrosSection: View {
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
    SobreNosotrosView()
}
