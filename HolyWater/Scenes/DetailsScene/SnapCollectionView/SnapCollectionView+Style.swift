//
//  SnapCollectionView+Style.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import UIKit

extension SnapCollectionView {

    struct Style {
        let backgroundImageView: UIImage?
        let backgroundImageViewAlpha: CGFloat
        let titleLabelFontSize: CGFloat
        let secondaryLabelFontSize: CGFloat

        static func defaultStyle() -> Self {
            .init(
                backgroundImageView: .init(named: "background"),
                backgroundImageViewAlpha: 0.6,
                titleLabelFontSize: 20,
                secondaryLabelFontSize: 14)
        }
    }
}
