//
//  HomeView.swift
//  Weather
//
//  Created by Даниял on 20.10.2022.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
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
                Text("Monreal")
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
