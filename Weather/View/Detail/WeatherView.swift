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
        GeometryReader { geometry in
            ZStack {
                background
                widgets
            }
            .safeAreaInset(edge: .top) {
                EmptyView()
                    .frame(height: deltaSafeAreaTopHeight + navigationHeight)
                    .padding(.bottom, 10)
            }
            .overlay {
                NavigationBar(searchText: $searchText,
                              height: navigationHeight,
                              addNewAddress: forecastManager.tryAddNewAddress)
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .navigationBarHidden(true)
            .searchable(text: $searchText)
        }
    }
    
    var background: some View {
        Color.background
            .ignoresSafeArea()
    }
    
    var widgets: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: spacingBetweenWidgets) {
                ForEach(searchedCities) { forecast in
                    WeatherWidget(forecast: forecast)
                        .transition(AnyTransition.asymmetric(insertion: .scale, removal: .scale))
                }
            }
        }
    }
    
    let spacingBetweenWidgets = valueRelativeHeight(20)
    let deltaSafeAreaTopHeight: CGFloat = 47 - valueRelativeHeight(47)
    let navigationHeight = valueRelativeHeight(106)
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
