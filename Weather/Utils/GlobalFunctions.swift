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


public func toHour12(date: Date) -> String {
    let dateAsString = date.formatted()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss"

    let date = dateFormatter.date(from: dateAsString)
    dateFormatter.dateFormat = "h a"
    let date12 = dateFormatter.string(from: date!)
    return date12
}
