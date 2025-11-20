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
                        Text(NSLocalizedString("politica_titulo", comment: "Título de la política de privacidad"))
                            .font(.largeTitle)
                            .bold()
                        Text(NSLocalizedString("politica_subtitulo", comment: "Subtítulo de la política de privacidad"))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top)
                    
                    // Secciones
                    PoliticaSection(
                        titulo: NSLocalizedString("politica_1_titulo", comment: "Sección 1 título"),
                        contenido: NSLocalizedString("politica_1_contenido", comment: "Sección 1 contenido")
                    )
                    
                    PoliticaSection(
                        titulo: NSLocalizedString("politica_2_titulo", comment: "Sección 2 título"),
                        contenido: NSLocalizedString("politica_2_contenido", comment: "Sección 2 contenido")
                    )
                    
                    PoliticaSection(
                        titulo: NSLocalizedString("politica_3_titulo", comment: "Sección 3 título"),
                        contenido: NSLocalizedString("politica_3_contenido", comment: "Sección 3 contenido")
                    )
                    
                    PoliticaSection(
                        titulo: NSLocalizedString("politica_4_titulo", comment: "Sección 4 título"),
                        contenido: NSLocalizedString("politica_4_contenido", comment: "Sección 4 contenido")
                    )
                    
                    PoliticaSection(
                        titulo: NSLocalizedString("politica_5_titulo", comment: "Sección 5 título"),
                        contenido: NSLocalizedString("politica_5_contenido", comment: "Sección 5 contenido")
                    )
                    
                    PoliticaSection(
                        titulo: NSLocalizedString("politica_6_titulo", comment: "Sección 6 título"),
                        contenido: NSLocalizedString("politica_6_contenido", comment: "Sección 6 contenido")
                    )
                    
                    PoliticaSection(
                        titulo: NSLocalizedString("politica_7_titulo", comment: "Sección 7 título"),
                        contenido: NSLocalizedString("politica_7_contenido", comment: "Sección 7 contenido")
                    )
                    
                    // Footer
                    VStack {
                        Divider()
                        Text(NSLocalizedString("politica_footer", comment: "Footer con derechos reservados"))
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

