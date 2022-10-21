//
//  WeatherWidget.swift
//  Weather
//
//  Created by Даниял on 21.10.2022.
//

import SwiftUI

struct WeatherWidget: View {
    var forecast: Forecast
    
    var body: some View {
        ZStack {
            Trapezoid()
                .fill(Color.weatherWidgetBackground)
                .frame(width: 342, height: 184)
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 24) {
                    Text("\(forecast.temperature)°")
                        .font(.system(size: 64).weight(.regular))
                    
                    VStack(alignment: .leading) {
                        Text("H:\(forecast.high)°   L:\(forecast.low)°")
                        Text("\(forecast.location)")
                            .lineLimit(1)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 0) {
                    Image("\(forecast.icon) large")
                    Text("\(forecast.weather.rawValue)")
                        .font(.system(size: 13).weight(.regular))
                        .padding(.trailing, 24)
                }
            }
            .foregroundColor(.white)
            .padding(.bottom, 20)
            .padding(.leading, 20)
        }
        .frame(width: 342, height: 184)
    }
}

struct WeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        WeatherWidget(forecast: Forecast.cities[0])
            .preferredColorScheme(.dark)
    }
}
