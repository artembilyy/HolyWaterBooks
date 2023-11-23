//
//  HeaderSectionSubview+Style.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import Foundation

extension HeaderSectionSubview {

    enum Style: String, CaseIterable {
        case readers, likes, quotes, genre

        var secondaryTitle: String {
            rawValue.capitalized
        }
    }
}
