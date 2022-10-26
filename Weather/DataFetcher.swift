//
//  DataFetcher.swift
//  Weather
//
//  Created by Даниял on 25.10.2022.
//

import Foundation

class DataFetcher {
    static func fetchForecast(url: String, fallBack: @escaping (Forecast) -> Void, failBack: @escaping () -> Void = {}) {
        guard let url = URL(string: url) else {
            failBack()
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                failBack()
                return
            }
            
            do {
                let forecast = try JSONDecoder().decode(Forecast.self, from: data)
                DispatchQueue.main.async {
                    fallBack(forecast)
                }
            } catch let error {
                failBack()
                print(error)
            }
        }.resume()
        
    }
}
