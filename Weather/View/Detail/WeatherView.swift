//
//  WeatherView.swift
//  Weather
//
//  Created by Даниял on 21.10.2022.
//

import SwiftUI

struct WeatherView: View {
    @State private var searchText = ""
    
    var searchedCities: [Forecast] {
        if searchText.isEmpty {
            return Forecast.cities
        }
        else {
            return Forecast.cities.filter { $0.location.contains(searchText) }
        }
    }
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(searchedCities) { forecast in
                        WeatherWidget(forecast: forecast)
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                EmptyView()
                    .frame(height: 110)
            }
        }
        .overlay {
            NavigationBar(searchText: $searchText)
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
                .preferredColorScheme(.dark)
        }
    }
}
