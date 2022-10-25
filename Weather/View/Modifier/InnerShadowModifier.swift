//
//  InnerShadowModifier.swift
//  Weather
//
//  Created by Даниял on 20.10.2022.
//

import SwiftUI

struct InnerShadowModifier<S: Shape, SS: ShapeStyle>: ViewModifier {
    var shape: S
    var color: SS
    var lineWidth: CGFloat = 1
    var offsetX: CGFloat = 0
    var offsetY: CGFloat = 0
    var blurRadius: CGFloat = 4
    var blendMode: BlendMode = .normal
    var opacity: Double = 1
    
    func body(content: Content) -> some View {
        content
            .overlay {
                shape
                    .stroke(color, lineWidth: lineWidth)
                    .blendMode(blendMode)
                    .offset(x: offsetX, y: offsetY)
                    .blur(radius: blurRadius)
                    .mask(shape)
                    .opacity(opacity)
        }
    }
}

extension View {
    func innerShadow<S: Shape, SS: ShapeStyle>(shape: S, color: SS, lineWidth: CGFloat = 1, offsetX: CGFloat = 0, offsetY: CGFloat = 0, blurRadius: CGFloat = 4, blendMode: BlendMode = .normal, opacity: Double = 1) -> some View{
        self.modifier(InnerShadowModifier(shape: shape, color: color, lineWidth: lineWidth, offsetX: offsetX, offsetY: offsetY, blurRadius: blurRadius, blendMode: blendMode, opacity: opacity))
    }
}
