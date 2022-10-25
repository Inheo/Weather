//
//  WeatherView.swift
//  Weather
//
//  Created by Даниял on 21.10.2022.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var forecastManager: ForecastManager
    @State private var searchText = ""
    
    var searchedCities: [CountryForecast] {
        if searchText.isEmpty {
            return forecastManager.allForecasts
        }
        else {
            return forecastManager.allForecasts.filter { $0.address.contains(searchText) }
        }
    }
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(searchedCities) { forecast in
                            WeatherWidget(countryForecast: forecast)
                                .transition(AnyTransition.asymmetric(insertion: .scale, removal: .scale))
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                EmptyView()
                    .frame(height: 110)
            }
        }
        .overlay {
            NavigationBar(searchText: $searchText,
                          addNewAddress:  forecastManager.tryAddNewAddress(newAddress:))
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarHidden(true)
        .searchable(text: $searchText)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WeatherView()
                .environmentObject(ForecastManager())
                .preferredColorScheme(.dark)
        }
    }
}
