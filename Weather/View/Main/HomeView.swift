//
//  HomeView.swift
//  Weather
//
//  Created by Даниял on 20.10.2022.
//

import SwiftUI
import BottomSheet

enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.83 // 702 / 844
    case middle = 0.385 // 325 / 844
    
    static func inverseLerp(value: CGFloat) -> CGFloat {
        (value - BottomSheetPosition.middle.rawValue) / (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }
    
    mutating func toggle() {
        self = self == .top ? .middle : .top
    }
}

struct HomeView: View {
    @EnvironmentObject var forecastManager: ForecastManager
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    @State var bottomSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
    @State var hasDragged = false
    
    var bottomSheetTranslationTime: CGFloat {
        BottomSheetPosition.inverseLerp(value: bottomSheetTranslation)
    }
    
    var screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        NavigationView {
            ZStack {
                // MARK: - Background
                backgroundItems
                
                // MARK: - Weather Information
                weatherInformation
                
                // MARK: - Bottom Sheet
                BottomSheetView(position: $bottomSheetPosition) {
//                    Text(bottomSheetTranslationTime.formatted())
                } content: {
                    ForecastView(translationTime: bottomSheetTranslationTime)
                }
                .onBottomSheetDrag { translation in
                    bottomSheetTranslation = translation / screenHeight
                    
                    withAnimation {
                        hasDragged = bottomSheetTranslationTime > 0.9
                    }
                }
                
                // MARK - Tab Bar
                TabBar(action: { bottomSheetPosition.toggle() })
                    .offset(y: bottomSheetTranslationTime * tabBarYOffset)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .ignoresSafeArea()
            }
            .navigationBarHidden(true)
        }
    }
    
    // MARK: - properties
    var backgroundItems: some View {
        Group {
            Color.background
                .ignoresSafeArea()
            
            Image("Background")
                .resizable()
                .scaleEffect(1.05)
                .offset(y: -bottomSheetTranslationTime * screenHeight * 1.1)
                .ignoresSafeArea()
            
            Image("House")
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 257)
                .offset(y: -bottomSheetTranslationTime * screenHeight)
        }
    }
    
    var weatherInformation: some View {
        VStack(spacing: -10 * (1 - bottomSheetTranslationTime)) {
            Text(forecastManager.address)
                .minimumScaleFactor(0.7)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .lineLimit(1)
            
            VStack {
                Text(attributedString)
                    .multilineTextAlignment(.center)
                
                Text("H:\(forecastManager.today.high.ToString())°   L:\(forecastManager.today.low.ToString())°")
                    .font(.title3.weight(.semibold))
                    .multilineTextAlignment(.center)
                    .opacity(1 - bottomSheetTranslationTime)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .foregroundColor(.white)
        .padding(.top, 51)
        .offset(y: -bottomSheetTranslationTime * weatherInformationYOffset)
    }
    
    var attributedString: AttributedString {
        // MARK: TODO change to current data
        let temperature = forecastManager.today.temperature.ToString()
        let conditions = forecastManager.today.conditions
        var string = AttributedString("\(temperature)°" + (hasDragged ? " | " : "\n") + conditions)
        
        if let temp = string.range(of: "\(temperature)°") {
            let size = lerp(min: temperatureMinimumFontSize, max: temperatureFontSize, time: bottomSheetTranslationTime)
            string[temp].font = .system(size: size,
                                        weight: hasDragged ? .semibold : .thin)
            string[temp].foregroundColor = hasDragged ? .secondary : .primary
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary
        }
        
        if let weather = string.range(of: conditions) {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        
        return string
    }
    
    // MARK: -
    let weatherInformationYOffset = valueRelativeHeight(46)
    let tabBarYOffset = valueRelativeHeight(115)
    let temperatureFontSize: CGFloat = 90
    let temperatureMinimumFontSize: CGFloat = 20
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
            .environmentObject(ForecastManager())
    }
}
