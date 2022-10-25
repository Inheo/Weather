//
//  WeatherApp.swift
//  Weather
//
//  Created by Даниял on 20.10.2022.
//

import SwiftUI

@main
struct WeatherApp: App {
    var forecastManager = ForecastManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .environmentObject(forecastManager)
        }
    }
}
