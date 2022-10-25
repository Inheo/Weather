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
                    .offset(y: bottomSheetTranslationTime * 115)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .ignoresSafeArea()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    // MARK: - properties
    var backgroundItems: some View {
        ZStack {
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
                .font(.largeTitle)
            
            VStack {
                Text(attributedString)
                    .multilineTextAlignment(.center)
                
                Text("H:\(String(format: "%.1f", forecastManager.today.high))°   L:\(String(format: "%.1f", forecastManager.today.low))°")
                    .font(.title3.weight(.semibold))
                    .multilineTextAlignment(.center)
                    .opacity(1 - bottomSheetTranslationTime)
            }
            
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.top, 51)
        .offset(y: -bottomSheetTranslationTime * 46)
    }
    
    var attributedString: AttributedString {
        // MARK: TODO change to current data
        let temperature = String(format: "%.1f", forecastManager.today.temperature)
        let conditions = forecastManager.today.conditions
        var string = AttributedString("\(temperature)°" + (hasDragged ? " | " : "\n") + conditions)
        
        if let temp = string.range(of: "\(temperature)°") {
            string[temp].font = .system(size: 96 - bottomSheetTranslationTime * (96 - 20),
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
            .environmentObject(ForecastManager())
    }
}
