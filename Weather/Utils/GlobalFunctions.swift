//
//  GlobalFunctions.swift
//  Weather
//
//  Created by Даниял on 28.10.2022.
//

import Foundation

public func lerp<T: FloatingPoint>(min: T, max: T, time: T) -> T {
    return max - time * (max - min)
}

public func inverseLerp<T: FloatingPoint>(min: T, max: T, value: T) -> T {
    return (value - min) / (max - min)
}
