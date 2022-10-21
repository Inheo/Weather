//
//  SegmentedControl.swift
//  Weather
//
//  Created by Даниял on 21.10.2022.
//

import SwiftUI

struct SegmentedControl: View {
    @Binding var selection: Int
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Button {
                    changeSelectionWithAnimation(0)
                } label: {
                    Text("Hourly Forecast")
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                
                Button {
                    changeSelectionWithAnimation(1)
                    
                } label: {
                    Text("Weakly Forecast")
                }
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            .font(.subheadline.weight(.semibold))
            .foregroundColor(.secondary)
            
            Divider()
                .background(.white.opacity(0.5))
                .blendMode(.overlay)
                .shadow(color: .black, radius: 0, x: 0, y: 1)
                .blendMode(.overlay)
                .overlay {
                    HStack() {
                        Divider()
                            .frame(width: UIScreen.main.bounds.width / 2,
                                   height: 3)
                            .background(Color.underline)
                            .blendMode(.overlay)
                    }
                    .frame(maxWidth: .infinity, alignment: selection == 0 ? .leading : .trailing)
                    .offset(y: -1)
                }
        }
        .padding(.top, 25)
    }
    
    func changeSelectionWithAnimation(_ selection: Int) {
        withAnimation(.easeInOut(duration: 0.5)) {
            self.selection = selection
        }
    }
}

struct SegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControl(selection: .constant(0))
    }
}
