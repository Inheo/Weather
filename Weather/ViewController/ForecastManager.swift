//
//  Weather.swift
//  Weather
//
//  Created by Даниял on 23.10.2022.
//

import Foundation

class ForecastManager: ObservableObject {
    var location = "Makhachkala"
    let key = "CP23LW7FNGLJNQR4ZJ844J5F2"
    
    private var addresses = Addresses()
    @Published private var currentForecast: Forecast?
    @Published private(set) var allForecasts: [CountryForecast]
    
    var url: String { "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(location)?unitGroup=metric&include=days%2Chours&key=\(key)&contentType=json"
    }
    
    init() {
        allForecasts = []
    
        addresses.load()
        
        addresses.forEach { address in
            self.location = address
            DataFetcher.fetchForecast(url: url, fallBack: { forecast in self.allForecasts.append(forecast.toCountryForecast()) })

        location = "Makhachkala"
        DataFetcher.fetchForecast(url: url, fallBack: { self.currentForecast = $0 })
        }
    }
    
    //MARK: - Intent
    
    var address: String {
        return currentForecast?.address ?? ""
    }
    
    var todayHours: [Hour] {
        return currentForecast?.days[0].hours ?? []
    }
    
    var today: Day {
        return currentForecast?.days[0] ?? Day(date: Date.now.formatted(), temperature: 0, high: 0, low: 0, probability: 0, conditions: "Wait please", hours: [])
    }
    
    var days: [Day] {
        return currentForecast?.days ?? []
    }
    
    func convertToBaseInformation(_ hour: Hour) -> BaseInforamation {
        return BaseInforamation(hour: hour)
    }
    
    func convertToBaseInformation(_ day: Day) -> BaseInforamation {
        return BaseInforamation(day: day)
    }
    
    func tryAddNewAddress(newAddress: String) {
        if newAddress.isEmpty || addresses.contains(newAddress) {
            return
        }

        addresses.addAddress(newAddress)
        location = newAddress
        
        DataFetcher.fetchForecast(url: url, fallBack: { forecast in
            self.allForecasts.append(forecast.toCountryForecast())
        })
    }
    
    func deleteAddres(_ address: String) {
        let index = addresses.delete(address)
        
        if index == -1 {
            return
        }
        allForecasts.remove(at: index)
    }
}
