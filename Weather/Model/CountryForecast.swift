//
//  CountryForecast.swift
//  Weather
//
//  Created by Даниял on 24.10.2022.
//

import Foundation

struct CountryForecast: Identifiable {
    var id = UUID()
    var forecast: Forecast
    
    var today: Day {
        return forecast.today
    }
    
    var address: String {
        return forecast.address
    }
}
