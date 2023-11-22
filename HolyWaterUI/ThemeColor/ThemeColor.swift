//
//  ThemeColor.swift
//  MatchedUI
//
//  Created by Артем Билый on 20.11.2023.
//

public enum ThemeColor: UInt, ColorConvertible {

    case black = 0x111111
    case white = 0xFFFFFF

    public var hexValue: UInt {
        rawValue
    }
}
