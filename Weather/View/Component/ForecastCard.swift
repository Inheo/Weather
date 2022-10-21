//
//  ForecastCard.swift
//  Weather
//
//  Created by Даниял on 21.10.2022.
//

import SwiftUI

struct ForecastCard: View {
    var forecast: Forecast
    var period: ForecastPeriod
    var isActive: Bool {
        if period == ForecastPeriod.hourly {
            let isThisHourly = Calendar.current.isDate(.now, equalTo: forecast.date, toGranularity: .hour)
            return isThisHourly
        }
        else {
            let isToday = Calendar.current.isDate(.now, equalTo: forecast.date, toGranularity: .day)
            return isToday
        }
    }
    
    var body: some View {
        ZStack {
            baseShape
                .fill(Color.forecastCardBackground.opacity(isActive ? 1 : 0.2))
                .frame(width: 60, height:  146)
                .shadow(color: .black.opacity(0.25), radius: 10, x: 5, y: 4)
                .overlay {
                    baseShape
                        .strokeBorder(.white.opacity(isActive ? 0.5 : 0.25))
                        .blendMode(.overlay)
                }
                .innerShadow(shape: baseShape,
                             color: .black,
                             offsetX: 1,
                             offsetY: 1,
                             blendMode: .overlay)
            
            VStack(spacing: 16) {
                Text(forecast.date, format: period == .hourly ? .dateTime.hour() : .dateTime.day())
                    .font(.subheadline.weight(.semibold))
                VStack(spacing: -4) {
                    Image("\(forecast.icon) small")
                    Text(forecast.probability, format: .percent)
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(Color.probabilityText)
                        .opacity(forecast.probability > 0 ? 1 : 0)
                }
                .frame(width: 44, height: 38)
                
                Text("\(forecast.temperature)°")
                    .font(.title3.weight(.regular))
                
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .frame(width: 60, height:  146)
        }
    }
    
    var baseShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 30)
    }
}

struct ForecastCard_Previews: PreviewProvider {
    static var previews: some View {
        ForecastCard(forecast: Forecast.hourly[0], period: .hourly)
    }
}
