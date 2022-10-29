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
                .frame(width: trapezoidWidth, height: trapezoidHeight)
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: valueRelativeWidth(24)) {
                    Text("\(forecast.today.temperature.ToString())°")
                        .font(.system(size: temperatureFontSize).weight(.regular))
                    
                    VStack(alignment: .leading) {
                        Text("H:\(forecast.today.high.ToString())°   L:\(forecast.today.low.ToString())°")
                        Text("\(forecast.address)")
                            .lineLimit(1)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 0) {
                    Image("Moon cloud fast wind large")
                    Text("\(forecast.today.conditions)")
                        .font(.system(size: conditionsFontSize).weight(.regular))
                        .padding(.trailing, valueRelativeWidth(24))
                }
            }
            .foregroundColor(.white)
            .padding(.bottom, valueRelativeWidth(20))
            .padding(.leading, valueRelativeWidth(20))
        }
        .frame(width: valueRelativeWidth(342), height: valueRelativeWidth(184))
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
    
    let trapezoidWidth = valueRelativeWidth(342)
    let trapezoidHeight = valueRelativeWidth(184)
    let temperatureFontSize = valueRelativeWidth(64)
    let conditionsFontSize = valueRelativeWidth(13)
}

struct WeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        WeatherWidget(forecast: CountryForecast(forecast: Forecast(address: "Moscow", days: [])))
            .environmentObject(ForecastManager())
            .preferredColorScheme(.dark)
    }
}
