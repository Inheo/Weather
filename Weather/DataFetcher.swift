//
//  DataFetcher.swift
//  Weather
//
//  Created by Даниял on 25.10.2022.
//

import Foundation

class DataFetcher {
    static func fetchForecast(url: String, fallBack: @escaping (Forecast) -> Void) {
        guard let url = URL(string: url) else {
            print("какая-то херь случилась братик")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                let forecast = try JSONDecoder().decode(Forecast.self, from: data)
                DispatchQueue.main.async {
                    fallBack(forecast)
                }
            } catch let error {
                print(error)
            }
        }.resume()
        
    }
}
