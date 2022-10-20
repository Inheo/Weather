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
}

struct HomeView: View {
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    
    var body: some View {
        NavigationView {
            ZStack {
                // MARK: - Background
                Color.background
                    .ignoresSafeArea()
                
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                
                Image("House")
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top, 257)
                
                VStack(spacing: -10) {
                    Text("Montreal")
                        .font(.largeTitle)
                    
                    VStack {
                        Text(attributedString)
                            .multilineTextAlignment(.center)
                        
                        Text("H:24°   L:18°")
                            .font(.title3.weight(.semibold))
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer()
                }
                .foregroundColor(.white)
                
                // MARk: - Bottom Sheet
                BottomSheetView(position: $bottomSheetPosition) {
                    
                } content: {
                    ForecastView()
                }
                
                // MARK - Tab Bar
                TabBar(action: {bottomSheetPosition = .top})
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    var attributedString: AttributedString {
        var string = AttributedString("19°\nMostly Clear")
        
        if let temp = string.range(of: "19°") {
            string[temp].font = .system(size: 96, weight: .thin)
            string[temp].foregroundColor = .primary
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary
        }
        
        if let weather = string.range(of: "Mostly Clear") {
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
    }
}
