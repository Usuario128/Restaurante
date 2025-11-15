//  MenuPedidoView.swift
//  Restaurante
//
//  Muestra los platillos del menú en tarjetas visuales sin separar por categorías.
//  AHORA INCLUYE: cerrar cuenta (vaciar pedidos + liberar mesa)

import SwiftUI

struct MenuPedidoView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var mesas: [Mesa]
    var mesa: Mesa
    @State private var menu = StorageMenu.shared.obtenerMenu()
    @State private var mostrarAlerta = false  // Para confirmar antes de cerrar cuenta
    
    // Índice de la mesa actual
    private var mesaIndex: Int? {
        mesas.firstIndex(where: { $0.id == mesa.id })
    }
    
    // Pedidos actuales
    private var pedidosActuales: [Platillo] {
        guard let idx = mesaIndex else { return [] }
        return mesas[idx].pedidos
    }
    
    // Total general
    private var totalMesa: Double {
        pedidosActuales.reduce(0) { $0 + $1.precio }
    }
    
    // MARK: - Funciones
    private func agregar(_ platillo: Platillo) {
        guard let idx = mesaIndex else { return }
        mesas[idx].pedidos.append(platillo)
        StorageMesas.shared.guardarMesas(mesas)
    }
    
    private func quitar(_ platillo: Platillo) {
        guard let idx = mesaIndex else { return }
        if let removeIdx = mesas[idx].pedidos.lastIndex(where: { $0.id == platillo.id }) {
            mesas[idx].pedidos.remove(at: removeIdx)
            StorageMesas.shared.guardarMesas(mesas)
        }
    }
    
    /// 🔴 Vacía la cuenta, elimina la reservación y libera la mesa
    private func cerrarCuenta() {
        guard let idx = mesaIndex else { return }
        mesas[idx].pedidos.removeAll()
        mesas[idx].reservacion = nil
        mesas[idx].disponible = true
        StorageMesas.shared.guardarMesas(mesas)
        dismiss()
    }
    
    // MARK: - Vista principal
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // 🔹 RECORRER TODAS LAS CATEGORÍAS
                    ForEach(Categoria.allCases, id: \.self) { categoria in

                        // FILTRAR PLATILLOS POR CATEGORÍA
                        let platillosCategoria = menu.filter { $0.categoria == categoria }

                        // SI NO HAY PLATILLOS EN ESA CATEGORÍA → NO MOSTRAR
                        if !platillosCategoria.isEmpty {

                            // TÍTULO DE CATEGORÍA
                            Text(categoria.rawValue.capitalized)
                                .font(.title2.bold())
                                .padding(.horizontal)

                            // GRID DE PLATILLOS
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)], spacing: 16) {
                                
                                ForEach(platillosCategoria) { platillo in
                                    VStack(spacing: 8) {
                                        
                                        // Imagen
                                        if let data = platillo.imagenData,
                                           let ui = UIImage(data: data) {
                                            Image(uiImage: ui)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(height: 100)
                                                .frame(maxWidth: .infinity)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                        } else {
                                            Image(systemName: "photo")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 100)
                                                .foregroundColor(.gray)
                                                .opacity(0.6)
                                        }
                                        
                                        // Información del platillo
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(platillo.nombre)
                                                .font(.headline)
                                                .lineLimit(1)
                                            
                                            if !platillo.descripcion.isEmpty {
                                                Text(platillo.descripcion)
                                                    .font(.caption)
                                                    .foregroundColor(.secondary)
                                                    .lineLimit(2)
                                            }
                                            
                                            Text(String(format: "$%.2f", platillo.precio))
                                                .font(.subheadline.bold())
                                                .foregroundColor(.green)
                                        }

                                        // CONTROLES DE CANTIDAD
                                        let cantidad = pedidosActuales.filter { $0.id == platillo.id }.count

                                        HStack {
                                            Button {
                                                quitar(platillo)
                                            } label: {
                                                Image(systemName: "minus.circle.fill")
                                                    .font(.title2)
                                                    .foregroundColor(cantidad > 0 ? .red : .gray)
                                            }
                                            .disabled(cantidad == 0)

                                            Text("x\(cantidad)")
                                                .font(.subheadline)
                                                .frame(width: 30)

                                            Button {
                                                agregar(platillo)
                                            } label: {
                                                Image(systemName: "plus.circle.fill")
                                                    .font(.title2)
                                                    .foregroundColor(.green)
                                            }
                                        }
                                    }
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color(.systemGray6))
                                            .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 2)
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.top)
            }

            
            // TOTAL + BOTONES
            VStack(spacing: 12) {
                HStack {
                    Text("💵 Total:")
                        .font(.headline)
                    Spacer()
                    Text(String(format: "$%.2f", totalMesa))
                        .font(.title3.bold())
                        .foregroundColor(.green)
                }
                .padding(.horizontal)
                
                HStack(spacing: 12) {
                    
                    // 🔴 BOTÓN CERRAR CUENTA
                    Button(role: .destructive) {
                        mostrarAlerta = true
                    } label: {
                        Text("Cerrar cuenta")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    // REGRESAR
                    Button {
                        dismiss()
                    } label: {
                        Text("Volver")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .background(Color(UIColor.systemBackground))
            .navigationTitle("Gestión de Pedido")
            .navigationBarTitleDisplayMode(.inline)
            
            // 🔔 ALERTA DE CONFIRMACIÓN
            .alert("¿Cerrar cuenta?", isPresented: $mostrarAlerta) {
                Button("Cancelar", role: .cancel) { }
                Button("Confirmar", role: .destructive) {
                    cerrarCuenta()
                }
            } message: {
                Text("Se eliminarán todos los pedidos y la mesa quedará disponible.")
            }
        }
        .onAppear {
            menu = StorageMenu.shared.obtenerMenu()
        }
    }
}
