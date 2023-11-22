//
//  SplashViewController+Style.swift
//  Matched
//
//  Created by Артем Билый on 20.11.2023.
//
//

import UIKit

extension SplashViewController {

    struct Style {
        let backgroundImage: UIImage
        let heartsImage: UIImage
        let titleImage: UIImage
        let subtitleImage: UIImage
        let titleImageViewTopPadding: CGFloat
        let subtitleImageViewTopPadding: CGFloat

        static func defaultStyle() -> Self {
            .init(
                backgroundImage: .init(named: "back") ?? .init(),
                heartsImage: .init(named: "hearts") ?? .init(),
                titleImage: .init(named: "title") ?? .init(),
                subtitleImage: .init(named: "subtitle") ?? .init(),
                titleImageViewTopPadding: 221,
                subtitleImageViewTopPadding: 12)
        }
    }
}
