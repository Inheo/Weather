//
//  ForecastCard.swift
//  Weather
//
//  Created by Даниял on 21.10.2022.
//

import SwiftUI

struct ForecastCard: View {
    var forecast: BaseInforamation
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
                .frame(width: valueRelativeWidth(60), height:  valueRelativeHeight(146))
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
            
            VStack(spacing: valueRelativeHeight(16)) {
                Text(forecast.date, format: period == .hourly ? .dateTime.hour() : .dateTime.weekday())
                    .font(.system(size: valueRelativeHeight(15)).weight(.semibold))
                
                VStack(spacing: valueRelativeHeight(-4)) {
                    Image("Moon cloud fast wind small")
                    Text(Int(forecast.probability), format: .percent)
                        .font(.system(size: valueRelativeHeight(13)).weight(.semibold))
                        .foregroundColor(Color.probabilityText)
                        .opacity(forecast.probability > 0 ? 1 : 0)
                }
                .frame(width: valueRelativeWidth(44), height: valueRelativeHeight(38))
                
                Text("\(forecast.temperature.ToString(zerosAfterPoint: 0))°")
                    .font(.system(size: valueRelativeHeight(20)).weight(.regular))
                
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .frame(width: width,
                   height: height)
        }
    }
    
    var baseShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 30)
    }
    
    let width = valueRelativeWidth(60)
    let height = valueRelativeHeight(146)
}

struct ForecastCard_Previews: PreviewProvider {
    static var previews: some View {
        let hour = BaseInforamation(hour: Hour(date: Date.now.formatted(), temperature: 0, probability: 20, conditions: ""))
        let day = BaseInforamation(day: Day(date: "2022-10-24", temperature: 0, high: 0, low: 0, probability: 30, conditions: "", hours: []))
        
        ForecastCard(forecast: day, period: .daily)
            .preferredColorScheme(.dark)
        
        ForecastCard(forecast: hour, period: .hourly)
            .preferredColorScheme(.dark)
    }
}
