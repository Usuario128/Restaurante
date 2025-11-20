import SwiftUI

struct TerminosDeUsoView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Encabezado
                    VStack(alignment: .leading, spacing: 8) {
                        Text(NSLocalizedString("terminos_titulo_principal", comment: "Título principal"))
                            .font(.largeTitle)
                            .bold()
                        Text(NSLocalizedString("terminos_subtitulo_principal", comment: "Subtítulo principal"))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top)
                    
                    // Secciones
                    TerminoSection(
                        titulo: NSLocalizedString("terminos_seccion_acceso", comment: "Acceso al sistema"),
                        contenido: NSLocalizedString("terminos_contenido_acceso", comment: "Contenido acceso")
                    )
                    
                    TerminoSection(
                        titulo: NSLocalizedString("terminos_seccion_responsabilidad", comment: "Responsabilidad del usuario"),
                        contenido: NSLocalizedString("terminos_contenido_responsabilidad", comment: "Contenido responsabilidad")
                    )
                    
                    TerminoSection(
                        titulo: NSLocalizedString("terminos_seccion_uso", comment: "Uso del sistema"),
                        contenido: NSLocalizedString("terminos_contenido_uso", comment: "Contenido uso del sistema")
                    )
                    
                    TerminoSection(
                        titulo: NSLocalizedString("terminos_seccion_cancelacion", comment: "Política de cancelación"),
                        contenido: NSLocalizedString("terminos_contenido_cancelacion", comment: "Contenido cancelación")
                    )
                    
                    TerminoSection(
                        titulo: NSLocalizedString("terminos_seccion_comentarios", comment: "Comentarios y valoraciones"),
                        contenido: NSLocalizedString("terminos_contenido_comentarios", comment: "Contenido comentarios")
                    )
                    
                    TerminoSection(
                        titulo: NSLocalizedString("terminos_seccion_propiedad", comment: "Propiedad intelectual"),
                        contenido: NSLocalizedString("terminos_contenido_propiedad", comment: "Contenido propiedad intelectual")
                    )
                    
                    TerminoSection(
                        titulo: NSLocalizedString("terminos_seccion_exoneracion", comment: "Exoneración de responsabilidad"),
                        contenido: NSLocalizedString("terminos_contenido_exoneracion", comment: "Contenido exoneración")
                    )
                    
                    TerminoSection(
                        titulo: NSLocalizedString("terminos_seccion_modificacion", comment: "Modificación de los términos"),
                        contenido: NSLocalizedString("terminos_contenido_modificacion", comment: "Contenido modificación")
                    )
                    
                    TerminoSection(
                        titulo: NSLocalizedString("terminos_seccion_ley", comment: "Ley aplicable"),
                        contenido: NSLocalizedString("terminos_contenido_ley", comment: "Contenido ley aplicable")
                    )
                    
                    // Footer
                    VStack {
                        Divider()
                        Text(NSLocalizedString("terminos_footer", comment: "Footer"))
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
            // Sin toolbar personalizado
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

