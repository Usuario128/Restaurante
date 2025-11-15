//
//  StorageMesas.swift
//  Restaurante
//
//  Created by win603 on 12/11/25.
//

import Foundation

class StorageMesas {
    static let shared = StorageMesas()
    private let key = "mesas_guardadas"
    
    func guardarMesas(_ mesas: [Mesa]) {
        if let data = try? JSONEncoder().encode(mesas) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func obtenerMesas() -> [Mesa] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        
        do {
            let mesas = try JSONDecoder().decode([Mesa].self, from: data)
            return mesas
        } catch {
            print("⚠️ Error al decodificar mesas: \(error)")
            // Si los datos viejos no son compatibles, se limpia para evitar crash
            UserDefaults.standard.removeObject(forKey: key)
            return []
        }
    }
}
