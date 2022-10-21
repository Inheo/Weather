//
//  ForecastView.swift
//  Weather
//
//  Created by Даниял on 20.10.2022.
//

import SwiftUI

struct ForecastView: View {
    var translationTime: CGFloat
    @State private var selection = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                SegmentedControl(selection: $selection)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(selection == 0 ? Forecast.hourly : Forecast.daily) { forecast in
                            ForecastCard(forecast: forecast, period: selection == 0 ? .hourly : .daily)
                                .transition(.offset(x: selection == 0 ? -430 : 430))
                        }
                    }
                    .padding(.vertical, 20)
                }
                .padding(.horizontal, 20)
            }
        }
        .backgroundBlur(radius: 25, opaque: true)
        .background(Color.bottomSheetBackground)
        .clipShape(RoundedRectangle(cornerRadius: 44))
        .innerShadow(shape: RoundedRectangle(cornerRadius: 44),
                     color: Color.bottomSheetBorderMiddle,
                     offsetY: 1,
                     blurRadius: 0,
                     blendMode: .overlay,
                     opacity: translationTime)
        .overlay {
            Divider()
                .blendMode(.overlay)
                .background(Color.bottomSheetBorderTop)
                .frame(maxHeight: .infinity, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 44))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .fill(.black.opacity(0.3))
                .frame(width: 48, height: 5)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 10)
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(translationTime: 1)
            .background(Color.background)
            .preferredColorScheme(.dark)
    }
}
