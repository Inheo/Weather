//
//  DataFetcher.swift
//  Weather
//
//  Created by Даниял on 25.10.2022.
//

import Foundation

class DataFetcher {
    static func fetchForecast(url: String, fallBack: @escaping (Forecast) -> Void, failBack: @escaping (String) -> Void = {_ in }) {
        guard let url = URL(string: url) else {
            failBack("Incorrect url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                failBack(error.localizedDescription)
            }
            
            guard let data = data else {
                failBack("Data is null")
                return
            }
            
            do {
                let forecast = try JSONDecoder().decode(Forecast.self, from: data)
                DispatchQueue.main.async {
                    fallBack(forecast)
                }
            } catch let error {
                failBack(error.localizedDescription)
            }
        }.resume()
        
    }
}
