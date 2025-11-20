//  PerfilUsuarioView.swift
//  Restaurante
//  Internacionalizado: inglés/español

import SwiftUI

struct HorarioEmpleado: Identifiable {
    let id = UUID()
    var tipoTurno: String
    var horaInicio: String
    var horaFin: String
}

struct PerfilUsuarioView: View {
    @ObservedObject private var storage = UserStorage.shared
    @Environment(\.dismiss) private var dismiss
    
    var usuario: Usuario
    var horarios: [HorarioEmpleado] = []
    
    // Diccionario de roles y tipos de turno amigables
    private let rolesAmigables: [Rol: String] = [
        .administrador: NSLocalizedString("administrador", comment: "Administrator"),
        .gerente: NSLocalizedString("gerente", comment: "Manager"),
        .empleado: NSLocalizedString("empleado", comment: "Employee"),
        .cliente: NSLocalizedString("cliente", comment: "Client")
    ]
    
    private let tiposTurnoAmigables: [String: String] = [
        "completo": NSLocalizedString("turno_completo", comment: "Full shift"),
        "vespertino": NSLocalizedString("turno_vespertino", comment: "Evening shift"),
        "matutino": NSLocalizedString("turno_matutino", comment: "Morning shift"),
        "nocturno": NSLocalizedString("turno_nocturno", comment: "Night shift")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            // 🔹 Encabezado
            VStack(spacing: 5) {
                Text(NSLocalizedString("perfil_titulo", comment: "User general info title"))
                    .font(.title)
                    .bold()
                Text(NSLocalizedString("perfil_subtitulo", comment: "Subtitle for user info"))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.top)
            
            // 🔹 Imagen de perfil
            if let imagenData = usuario.imagenData,
               let uiImage = UIImage(data: imagenData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            } else {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 130, height: 130)
                    .overlay(
                        Text(NSLocalizedString("sin_imagen", comment: "No image available"))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                    )
            }
            
            // 🔹 Información del usuario
            VStack(alignment: .leading, spacing: 10) {
                InfoRow(label: NSLocalizedString("label_nombre", comment: ""), value: usuario.nombre)
                InfoRow(label: NSLocalizedString("label_email", comment: ""), value: usuario.email)
                InfoRow(label: NSLocalizedString("label_telefono", comment: ""), value: usuario.telefono)
                InfoRow(label: NSLocalizedString("label_direccion", comment: ""), value: usuario.direccion)
                InfoRow(label: NSLocalizedString("label_rol", comment: ""), value: rolesAmigables[usuario.rol] ?? "Unknown")
                InfoRow(label: NSLocalizedString("label_estado", comment: ""), value: usuario.activo ? NSLocalizedString("estado_activo", comment: "") : NSLocalizedString("estado_inactivo", comment: ""))
                InfoRow(label: NSLocalizedString("label_fecha_registro", comment: ""), value: Date.now.formatted(date: .numeric, time: .omitted))
                InfoRow(label: NSLocalizedString("label_hora_registro", comment: ""), value: Date.now.formatted(date: .omitted, time: .standard))
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal)
            
            // 🔹 Horarios de trabajo
            if !horarios.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text(NSLocalizedString("horarios_titulo", comment: "Work schedule title"))
                        .font(.headline)
                    ForEach(horarios) { horario in
                        VStack(alignment: .leading, spacing: 5) {
                            InfoRow(label: NSLocalizedString("label_tipo_turno", comment: ""), value: tiposTurnoAmigables[horario.tipoTurno] ?? horario.tipoTurno)
                            InfoRow(label: NSLocalizedString("label_hora_inicio", comment: ""), value: horario.horaInicio)
                            InfoRow(label: NSLocalizedString("label_hora_fin", comment: ""), value: horario.horaFin)
                        }
                        Divider()
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
            }
            
            Spacer()
            
            // 🔹 Botón regresar
            Button(action: { dismiss() }) {
                Text(NSLocalizedString("boton_regresar", comment: "Back button"))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .navigationBarBackButtonHidden(true)
    }
}

// Vista auxiliar para filas de información
struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label + ":")
                .bold()
            Spacer()
            Text(value)
        }
        .font(.subheadline)
    }
}

struct PerfilUsuarioView_Previews: PreviewProvider {
    static var previews: some View {
        let usuario = Usuario(
            nombre: "Carlos Pérez",
            email: "carlos@restaurante.com",
            telefono: "555-1234",
            direccion: "Calle Luna 45",
            password: "1234",
            rol: .empleado,
            activo: true
        )
        
        let horarios = [
            HorarioEmpleado(tipoTurno: "matutino", horaInicio: "08:00", horaFin: "14:00"),
            HorarioEmpleado(tipoTurno: "vespertino", horaInicio: "14:00", horaFin: "20:00")
        ]
        
        PerfilUsuarioView(usuario: usuario, horarios: horarios)
    }
}

