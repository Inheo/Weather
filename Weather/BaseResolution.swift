//
//  BaseResolution.swift
//  Weather
//
//  Created by Даниял on 28.10.2022.
//

import Foundation
import UIKit

struct BaseResolution {
    private static let baseWidth: CGFloat = 390
    private static let baseHeight: CGFloat = 844
    
    private static let widthMultiplier = currentWidth / baseWidth
    private static let heightMultiplier = currentHeight / baseHeight
    
    private static var currentWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    private static var currentHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static func valueRelativeWidth(_ value: CGFloat) -> CGFloat {
        valueRelativeSide(value, widthMultiplier)
    }
    
    static func valueRelativeHeight(_ value: CGFloat) -> CGFloat {
        valueRelativeSide(value, heightMultiplier)
    }
    
    private static func valueRelativeSide(_ value: CGFloat, _ multiplier: CGFloat) -> CGFloat {
        return value * multiplier
    }
}

func valueRelativeWidth(_ value: CGFloat) -> CGFloat {
    BaseResolution.valueRelativeWidth(value)
}

func valueRelativeHeight(_ value: CGFloat) -> CGFloat {
    BaseResolution.valueRelativeHeight(value)
}
