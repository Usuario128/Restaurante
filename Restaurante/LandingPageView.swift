//
//  LandingPageView.swift
//  Restaurante
//
//  Created by win603 on 07/11/25.
//

import SwiftUI

struct LandingPageView: View {
    // Cargar automáticamente todas las imágenes del proyecto con prefijo "f"
    @State private var imagenes: [String] = []
    @State private var indiceActual = 0
    @State private var temporizadorActivo = true
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                // Encabezado
                VStack(alignment: .center, spacing: 8) {
                    Text("ReservaMesa")
                        .font(.largeTitle)
                        .bold()
                    
                    // Texto combinado en una sola línea adaptable
                    Text("El sitio que te permitirá registrarte y gestionar tus reservas de manera fácil")
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
                    // Mensaje en caso de no encontrar imágenes
                    Text("No se encontraron imágenes en los assets.")
                        .foregroundColor(.secondary)
                        .padding()
                }
                
                // Navegación de botones
                VStack(spacing: 12) {
                    NavigationLink(destination: PoliticaDePrivacidadView()) {
                        BotonNavegacion(titulo: "Política de Privacidad", color: .green)
                    }
                    NavigationLink(destination: TerminosDeUsoView()) {
                        BotonNavegacion(titulo: "Términos de Uso", color: .orange)
                    }
                    NavigationLink(destination: SobreNosotrosView()) {
                        BotonNavegacion(titulo: "Sobre Nosotros", color: .purple)
                    }
                    NavigationLink(destination: LoginView()) {
                        BotonNavegacion(titulo: "Iniciar Sesión", color: .pink)
                    }
                    NavigationLink(destination: RegistroView()) {
                        BotonNavegacion(titulo: "Registrarse", color: .teal)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 10)
                
                Spacer()
                
                // Footer
                VStack {
                    Divider()
                    Text("© 2024 ReservaMesa. Todos los derechos reservados.")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 10)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                cargarImagenesLocales()
            }
        }
    }
    
    // MARK: - Función para cargar automáticamente las imágenes desde los Assets
    func cargarImagenesLocales() {
        var nombres: [String] = []
        var index = 1
        
        // Intenta cargar imágenes con nombres f1, f2, f3... hasta que no encuentre más
        while UIImage(named: "f\(index)") != nil {
            nombres.append("f\(index)")
            index += 1
        }
        
        // Si no hay ninguna con el formato f1, f2..., busca otras por fallback (opcional)
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
