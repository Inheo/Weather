//
//  ForcastModel.swift
//  Weather
//
//  Created by Даниял on 21.10.2022.
//

import Foundation

enum ForecastPeriod {
    case hourly
    case daily
}

enum Weather: String {
    case clear = "Clear"
    case cloudy = "Cloudy"
    case rainy = "Mid Rain"
    case stormy = "Showers"
    case sunny = "Sunny"
    case tornado = "Tornado"
    case windy = "Fast Wind"
}

struct Forecast: Codable {
    var address: String
    var days: [Day]
    
    var today: Day {
        return days.first ?? Day(date: Date.now.formatted(), temperature: 0, high: 0, low: 0, probability: 0, conditions: "", hours: [])
    }
}

struct Day: Codable, Identifiable {
    var id = UUID()
    var date: String
    var temperature: Double
    var high: Double
    var low: Double
    var probability: Double
    var conditions: String
    var hours: [Hour]
    
    enum CodingKeys: String, CodingKey {
        case date = "datetime"
        case temperature = "temp"
        case high = "tempmax"
        case low = "tempmin"
        case probability = "precipprob"
        case conditions = "conditions"
        case hours = "hours"
    }
}

struct Hour: Codable, Identifiable {
    var id = UUID()
    var date: String
    var temperature: Double
    var probability: Double
    var conditions: String
    
    enum CodingKeys: String, CodingKey {
        case date = "datetime"
        case temperature = "temp"
        case probability = "precipprob"
        case conditions = "conditions"
    }
}

struct BaseInforamation {
    var date: Date
    var temperature: Double
    var probability: Double
    
    init(hour: Hour) {
        date = Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: hour.date.ToDate(format: "HH:mm:ss")), minute: 0, second: 0, of: Date()) ?? .now
        temperature = hour.temperature
        probability = hour.probability
    }
    
    init(day: Day) {
        date = day.date.ToDate()
        temperature = day.temperature
        probability = day.probability
    }
}
