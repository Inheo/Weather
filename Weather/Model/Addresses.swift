//
//  Addresses.swift
//  Weather
//
//  Created by Даниял on 25.10.2022.
//

import Foundation

struct Addresses {
    let key = "addresses"
    var addresses: [String] = []
    
    mutating func addAddress(_ address: String) {
        addresses.append(address)
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
}
