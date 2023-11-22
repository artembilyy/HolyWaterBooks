//
//  FontConvertible.swift
//  MatchedUI
//
//  Created by Артем Билый on 20.11.2023.
//

public protocol FontConvertible {
    var fontName: String { get }
    var fontSize: CGFloat { get }
    var font: UIFont { get }
}

public extension FontConvertible {

    var font: UIFont {
        .init(
            name: fontName,
            size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
}
