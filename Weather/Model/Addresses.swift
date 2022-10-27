//
//  Addresses.swift
//  Weather
//
//  Created by Даниял on 25.10.2022.
//

import Foundation

struct Addresses {
    let key = "addresses"
    private var addresses: [String] = []
    
    mutating func addAddress(_ address: String) {
        addresses.append(address)
        saveAddresses()
    }
    
    mutating func delete(_ address: String) {
        guard let index = addresses.firstIndex(of: address) else {
            return
        }
        
        addresses.remove(at: index)
        saveAddresses()
    }
    
    mutating func load() {
        if let json = UserDefaults.standard.data(forKey: key),
           let decodedAddresses = try? JSONDecoder().decode([String].self, from: json){
            addresses = decodedAddresses
        }
        else {
            addresses = ["Moscow", "Krasnodar", "New-York", "Ottawa"]
        }
    }
    
    func saveAddresses() {
        UserDefaults.standard.set(try? JSONEncoder().encode(addresses), forKey: key)
    }
    
    func forEach(_ body: (String) -> Void) {
        addresses.forEach{ address in body(address) }
    }
    
    func contains(_ address: String) -> Bool {
        return addresses.contains(address)
    }
}
