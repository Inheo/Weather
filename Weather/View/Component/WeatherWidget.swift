//
//  WeatherWidget.swift
//  Weather
//
//  Created by Даниял on 21.10.2022.
//

import SwiftUI

struct WeatherWidget: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var forecastManager: ForecastManager
    var forecast: CountryForecast
    
    var body: some View {
        ZStack {
            Trapezoid()
                .fill(Color.weatherWidgetBackground)
                .frame(width: 342, height: 184)
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 24) {
                    Text("\(String(format: "%.1f", forecast.today.temperature))°")
                        .font(.system(size: 64).weight(.regular))
                    
                    VStack(alignment: .leading) {
                        Text("H:\(String(format: "%.1f", forecast.today.high))°   L:\(String(format:"%.1f", forecast.today.low))°")
                        Text("\(forecast.address)")
                            .lineLimit(1)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 0) {
                    Image("Moon cloud fast wind large")
                    Text("\(forecast.today.conditions)")
                        .font(.system(size: 13).weight(.regular))
                        .padding(.trailing, 24)
                }
            }
            .foregroundColor(.white)
            .padding(.bottom, 20)
            .padding(.leading, 20)
        }
        .frame(width: 342, height: 184)
        .gesture(deleteTap().exclusively(before: chooseTap()))
    }
    
    func deleteTap() -> some Gesture {
        TapGesture(count: 3)
            .onEnded {
                withAnimation {
                    forecastManager.deleteAddres(forecast.address)
                }
        }
    }
    
    func chooseTap() -> some Gesture {
        TapGesture(count: 1)
            .onEnded {
                dismiss()
                forecastManager.changeCurrentForecast(forecast.forecast)
            }
    }
}

struct WeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        WeatherWidget(forecast: CountryForecast(forecast: Forecast(address: "Moscow", days: [])))
            .environmentObject(ForecastManager())
            .preferredColorScheme(.dark)
    }
}
