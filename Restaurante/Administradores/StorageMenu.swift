//
//  StorageMenu.swift
//  Restaurante
//

import Foundation

class StorageMenu {
    static let shared = StorageMenu()
    private let key = "menu_guardado"
    
    func guardarMenu(_ menu: [Platillo]) {
        if let data = try? JSONEncoder().encode(menu) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func obtenerMenu() -> [Platillo] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let menu = try? JSONDecoder().decode([Platillo].self, from: data) else {
            return []
        }
        return menu
    }
}
