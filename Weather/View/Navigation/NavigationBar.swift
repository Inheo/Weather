//
//  NavigationBar.swift
//  Weather
//
//  Created by Даниял on 21.10.2022.
//

import SwiftUI

struct NavigationBar: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            VStack(spacing: 8) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 5) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 24).weight(.medium))
                                .foregroundColor(.secondary)
                            Text("Weather")
                                .font(.system(size: 28).weight(.regular))
                                .foregroundColor(.primary)
                        }
                        .frame(height: 44)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "ellipsis.circle")
                        .font(.system(size: 28).weight(.regular))
                    //                    .frame(width: 34, height: 34, alignment: .trailing)
                }
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 106, alignment: .top)
        .background(Color.navBarBackground)
        .backgroundBlur(radius: 20, opaque: true)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}
