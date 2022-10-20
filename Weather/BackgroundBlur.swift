//
//  BackgroundBlur.swift
//  Weather
//
//  Created by Даниял on 20.10.2022.
//

import SwiftUI

struct BlurModifier: ViewModifier {
    var radius: CGFloat = 3
    var opaque = false
    
    func body(content: Content) -> some View {
        content.background(Blur(radius: radius, opaque: opaque))
    }
}

extension View {
    func backgroundBlur(radius: CGFloat, opaque: Bool) -> some View {
        self.modifier(BlurModifier(radius: radius, opaque: opaque))
    }
}
