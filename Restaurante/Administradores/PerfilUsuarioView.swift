//
//  PerfilUsuarioView.swift
//  Restaurante
//
//  Created by win603 on 10/11/25.
//

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
        .administrador: "Administrador",
        .gerente: "Gerente",
        .empleado: "Empleado",
        .cliente: "Cliente"
    ]
    
    private let tiposTurnoAmigables: [String: String] = [
        "completo": "Completo",
        "vespertino": "Vespertino",
        "matutino": "Matutino",
        "nocturno": "Nocturno"
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            // Encabezado
            VStack(spacing: 5) {
                Text("Datos Generales del Usuario")
                    .font(.title)
                    .bold()
                Text("Aquí se puede visualizar la información del usuario")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.top)
            
            // Imagen de perfil
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
                    .overlay(Text("Sin\nImagen").multilineTextAlignment(.center).foregroundColor(.gray))
            }
            
            // Información del usuario
            VStack(alignment: .leading, spacing: 10) {
                InfoRow(label: "Nombre", value: usuario.nombre)
                InfoRow(label: "Email", value: usuario.email)
                InfoRow(label: "Teléfono", value: usuario.telefono)
                InfoRow(label: "Dirección", value: usuario.direccion)
                InfoRow(label: "Rol", value: rolesAmigables[usuario.rol] ?? "Desconocido")
                InfoRow(label: "Estado", value: usuario.activo ? "Activo" : "Inactivo")
                InfoRow(label: "Fecha de Registro", value: Date.now.formatted(date: .numeric, time: .omitted))
                InfoRow(label: "Hora de Registro", value: Date.now.formatted(date: .omitted, time: .standard))
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal)
            
            // Horarios (solo si aplica)
            if !horarios.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Horarios de trabajo")
                        .font(.headline)
                    ForEach(horarios) { horario in
                        VStack(alignment: .leading, spacing: 5) {
                            InfoRow(label: "Tipo de Turno", value: tiposTurnoAmigables[horario.tipoTurno] ?? horario.tipoTurno)
                            InfoRow(label: "Hora Inicio", value: horario.horaInicio)
                            InfoRow(label: "Hora Fin", value: horario.horaFin)
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
            
            // Botón de regresar
            Button(action: {
                dismiss()
            }) {
                Text("Regresar")
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
