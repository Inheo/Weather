//
//  WeatherWidget.swift
//  Weather
//
//  Created by Даниял on 21.10.2022.
//

import SwiftUI

struct WeatherWidget: View {
    @EnvironmentObject var forecastManager: ForecastManager
    var countryForecast: CountryForecast
    
    var body: some View {
        ZStack {
            Trapezoid()
                .fill(Color.weatherWidgetBackground)
                .frame(width: 342, height: 184)
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 24) {
                    Text("\(String(format: "%.1f", countryForecast.today.temperature))°")
                        .font(.system(size: 64).weight(.regular))
                    
                    VStack(alignment: .leading) {
                        Text("H:\(String(format: "%.1f", countryForecast.today.high))°   L:\(String(format:"%.1f", countryForecast.today.low))°")
                        Text("\(countryForecast.address)")
                            .lineLimit(1)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 0) {
                    Image("Moon cloud fast wind large")
                    Text("\(countryForecast.today.conditions)")
                        .font(.system(size: 13).weight(.regular))
                        .padding(.trailing, 24)
                }
            }
            .foregroundColor(.white)
            .padding(.bottom, 20)
            .padding(.leading, 20)
        }
        .frame(width: 342, height: 184)
        .onTapGesture(count: 3, perform: {
            withAnimation {
                forecastManager.deleteAddres(countryForecast.address)
            }
        })
    }
}

struct WeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        WeatherWidget(countryForecast: CountryForecast(forecast: Forecast(address: "Moscow", days: [])))
            .environmentObject(ForecastManager())
            .preferredColorScheme(.dark)
    }
}
