//
//  TabBar.swift
//  Weather
//
//  Created by Даниял on 20.10.2022.
//

import SwiftUI

struct TabBar: View {
    var action: () -> Void
    
    var body: some View {
        ZStack {
            // MARK: - Arc Shape
            arc
            // MARK: - Tab Items
            HStack {
                // MARK: Expand Button
                expandButton
                Spacer()
                // MARK: Navigation Button
                navigationButton
            }
            .font(.title2)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 20, leading: 32, bottom: 24, trailing: 32))
        }
    }
    
    
    var arc: some View {
        Arc()
            .fill(Color.tabBarBackground)
            .frame(height: arcHeight)
            .overlay {
                Arc()
                    .stroke(Color.tabBarBackground, lineWidth: 0.5)
            }
    }
    
    var expandButton: some View {
        Button {
            action()
        } label: {
            Image(systemName: "mappin.and.ellipse")
                .frame(width: buttonBaseHeight, height: buttonBaseHeight)
        }

    }
    
    var navigationButton: some View {
        NavigationLink {
            WeatherView()
        } label: {
            Image(systemName: "list.star")
                .frame(width: buttonBaseHeight, height: buttonBaseHeight)
        }
    }
    
    // MARK: -
    let arcHeight = valueRelativeHeight(88)
    let buttonBaseHeight = valueRelativeHeight(44)
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(action: {})
            .preferredColorScheme(.dark)
    }
}
