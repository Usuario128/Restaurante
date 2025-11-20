import SwiftUI

struct SobreNosotrosView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Encabezado
                    VStack(alignment: .leading, spacing: 8) {
                        Text(NSLocalizedString("sobre_titulo_principal", comment: "Título principal"))
                            .font(.largeTitle)
                            .bold()
                        Text(NSLocalizedString("sobre_subtitulo_principal", comment: "Subtítulo principal"))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top)
                    
                    // Secciones
                    SobreNosotrosSection(
                        titulo: NSLocalizedString("sobre_seccion_acerca", comment: "Sección acerca de"),
                        contenido: NSLocalizedString("sobre_contenido_acerca", comment: "Contenido acerca de")
                    )
                    
                    SobreNosotrosSection(
                        titulo: NSLocalizedString("sobre_seccion_como_funciona", comment: "Sección cómo funciona"),
                        contenido: NSLocalizedString("sobre_contenido_como_funciona", comment: "Contenido cómo funciona")
                    )
                    
                    SobreNosotrosSection(
                        titulo: NSLocalizedString("sobre_seccion_servicios", comment: "Sección servicios"),
                        contenido: NSLocalizedString("sobre_contenido_servicios", comment: "Contenido servicios")
                    )
                    
                    SobreNosotrosSection(
                        titulo: NSLocalizedString("sobre_seccion_contacto", comment: "Sección contacto"),
                        contenido: NSLocalizedString("sobre_contenido_contacto", comment: "Contenido contacto")
                    )
                    
                    // Footer
                    VStack {
                        Divider()
                        Text(NSLocalizedString("sobre_footer", comment: "Footer"))
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 20)
                }
                .padding(.horizontal)
            }
            .navigationTitle("") // Sin título grande
            .navigationBarTitleDisplayMode(.inline)
            // No toolbar personalizado
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

