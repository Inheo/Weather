//
//  ForecastView.swift
//  Weather
//
//  Created by Даниял on 20.10.2022.
//

import SwiftUI

struct ForecastView: View {
    @EnvironmentObject var forecastManager: ForecastManager
    @State private var selection = 0
    var translationTime: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            SegmentedControl(selection: $selection)
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    forecastCards
                        .padding(.vertical, valueRelativeHeight(20))
                }
                .padding(.horizontal, 20)
                
                Image("Forecast Widgets")
                    .opacity(translationTime)
            }
        }
        .backgroundBlur(radius: 25, opaque: true)
        .background(Color.bottomSheetBackground)
        .clipShape(baseShape)
        .innerShadow(shape: baseShape,
                     color: Color.bottomSheetBorderMiddle,
                     offsetY: 1,
                     blurRadius: 0,
                     blendMode: .overlay,
                     opacity: 1 - translationTime)
        .overlay {
            topLine
        }
        .overlay {
            rectangleHold
        }
    }
    
    var topLine: some View {
        Divider()
            .blendMode(.overlay)
            .background(Color.bottomSheetBorderTop)
            .frame(maxHeight: .infinity, alignment: .top)
            .clipShape(baseShape)
    }
    
    var rectangleHold: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.black.opacity(0.3))
            .frame(width: 48, height: 5)
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 10)
    }
    
    var forecastCards: some View {
        HStack(spacing: 12) {
            if selection == 0 {
                ForEach(forecastManager.todayHours) { forecast in
                    ForecastCard(forecast: forecastManager.convertToBaseInformation(forecast), period: .hourly)
                        .transition(.offset(x: selection == 0 ? -transitionOffset : transitionOffset))
                }
            }
            else {
                ForEach(forecastManager.days) { forecast in
                    ForecastCard(forecast: forecastManager.convertToBaseInformation(forecast), period: .daily)
                        .transition(.offset(x: selection == 0 ? -transitionOffset : transitionOffset))
                }
            }
        }
    }
    
    let transitionOffset: CGFloat = 430
    let baseShape = RoundedRectangle(cornerRadius: 44)
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(translationTime: 1)
            .background(Color.background)
            .preferredColorScheme(.dark)
            .environmentObject(ForecastManager())
    }
}
