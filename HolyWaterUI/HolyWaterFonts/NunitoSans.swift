//
//  NunitoSans.swift
//  HolyWaterUI
//
//  Created by Артем Билый on 27.11.2023.
//

import Foundation

public enum NunitoSans: FontConvertible {

    case bold(CGFloat)
    case semiBold(CGFloat)

    public var fontName: String {
        switch self {
        case .bold:
            return "NunitoSans10pt-Bold"
        case .semiBold:
            return "NunitoSans10pt-SemiBold"
        }
    }

    public var fontSize: CGFloat {
        switch self {
        case .bold(let size), .semiBold(let size):
            return size
        }
    }
}
