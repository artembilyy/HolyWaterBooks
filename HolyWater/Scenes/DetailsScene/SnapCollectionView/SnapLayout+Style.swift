//
//  SnapLayout+Style.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import UIKit

extension SnapLayout {

    struct Style {
        let activeDistance: CGFloat
        let zoomFactor: CGFloat
        let spacing: CGFloat
        let itemSize: CGSize

        static func defaultStyle() -> Self {
            .init(
                activeDistance: 160,
                zoomFactor: 0.25,
                spacing: 32,
                itemSize: .init(width: 160, height: 200))
        }
    }
}
