//
//  WeatherView.swift
//  Weather
//
//  Created by Даниял on 21.10.2022.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
        }
        .overlay {
            NavigationBar()
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarHidden(true)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
            .preferredColorScheme(.dark)
    }
}
