//
//  ThemeColor.swift
//  MatchedUI
//
//  Created by Артем Билый on 20.11.2023.
//

public enum ThemeColor: UInt, ColorConvertible {

    case black = 0x111111
    case chaosBlack = 0x101010
    case white = 0xFFFFFF
    case silver = 0xC4C4C4
    case lightGray = 0xD9D5D6
    case byzantium = 0x532454
    case raspberryPink = 0xDD48A1
    case raisinBlack = 0x302A31
    case eigengrau = 0x140D14
    case jetBlack = 0x393637

    public var hexValue: UInt {
        rawValue
    }
}
