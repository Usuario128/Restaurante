//
//  LandingPageView.swift
//  Restaurante
//

import SwiftUI

struct LandingPageView: View {
    @State private var imagenes: [String] = []
    @State private var indiceActual = 0
    @State private var temporizadorActivo = true
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                // Encabezado
                VStack(alignment: .center, spacing: 8) {
                    Text(NSLocalizedString("titulo_reservamesa", comment: ""))
                        .font(.largeTitle)
                        .bold()
                    
                    Text(NSLocalizedString("subtitulo_descripcion", comment: ""))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(2)
                }
                .padding(.top, 20)
                .padding(.horizontal)
                
                // Carrusel dinámico
                if !imagenes.isEmpty {
                    TabView(selection: $indiceActual) {
                        ForEach(0..<imagenes.count, id: \.self) { index in
                            Image(imagenes[index])
                                .resizable()
                                .scaledToFill()
                                .frame(height: 250)
                                .clipped()
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .frame(height: 260)
                    .onAppear {
                        startAutoScroll()
                    }
                } else {
                    Text(NSLocalizedString("mensaje_no_imagenes", comment: ""))
                        .foregroundColor(.secondary)
                        .padding()
                }
                
                // Navegación de botones
                VStack(spacing: 12) {
                    NavigationLink(destination: PoliticaDePrivacidadView()) {
                        BotonNavegacion(
                            titulo: NSLocalizedString("boton_politica", comment: ""),
                            color: .green
                        )
                    }
                    NavigationLink(destination: TerminosDeUsoView()) {
                        BotonNavegacion(
                            titulo: NSLocalizedString("boton_terminos", comment: ""),
                            color: .orange
                        )
                    }
                    NavigationLink(destination: SobreNosotrosView()) {
                        BotonNavegacion(
                            titulo: NSLocalizedString("boton_sobre_nosotros", comment: ""),
                            color: .purple
                        )
                    }
                    NavigationLink(destination: LoginView()) {
                        BotonNavegacion(
                            titulo: NSLocalizedString("boton_iniciar_sesion", comment: ""),
                            color: .pink
                        )
                    }
                    NavigationLink(destination: RegistroView()) {
                        BotonNavegacion(
                            titulo: NSLocalizedString("boton_registrarse", comment: ""),
                            color: .teal
                        )
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 10)
                
                Spacer()
                
                // Footer
                VStack {
                    Divider()
                    Text(NSLocalizedString("footer_derechos", comment: ""))
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 10)
                }
            }
            .navigationBarHidden(true)    // ← OCULTA LA BARRA DE NAVEGACIÓN
            .onAppear {
                cargarImagenesLocales()
            }
        }
    }
    
    // MARK: - Cargar imágenes locales automáticamente
    func cargarImagenesLocales() {
        var nombres: [String] = []
        var index = 1

        while UIImage(named: "f\(index)") != nil {
            nombres.append("f\(index)")
            index += 1
        }
        
        if nombres.isEmpty {
            let posibles = ["imagen1", "imagen2", "foto1", "foto2"]
            for nombre in posibles where UIImage(named: nombre) != nil {
                nombres.append(nombre)
            }
        }
         
        self.imagenes = nombres
    }

    // MARK: - Carrusel automático
    func startAutoScroll() {
        Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
            if temporizadorActivo && !imagenes.isEmpty {
                withAnimation {
                    indiceActual = (indiceActual + 1) % imagenes.count
                }
            }
        }
    }
}

// MARK: - Vista del botón de navegación reutilizable
struct BotonNavegacion: View {
    let titulo: String
    let color: Color
    
    var body: some View {
        Text(titulo)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(color.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(radius: 3)
    }
}

#Preview {
    LandingPageView()
}

