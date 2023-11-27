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
        let backgroundImage: UIImage?
        let heartsImage: UIImage?
        let titleImage: UIImage?
        let subtitleImage: UIImage?
        let titleImageViewTopPadding: CGFloat
        let subtitleImageViewTopPadding: CGFloat
        let progressBarViewTopPadding: CGFloat
        let progressBarViewWidth: CGFloat
        let progressBarViewHeight: CGFloat

        static func defaultStyle() -> Self {
            .init(
                backgroundImage: .init(named: "back"),
                heartsImage: .init(named: "hearts"),
                titleImage: .init(named: "title"),
                subtitleImage: .init(named: "subtitle"),
                titleImageViewTopPadding: 221,
                subtitleImageViewTopPadding: 12,
                progressBarViewTopPadding: 19,
                progressBarViewWidth: 274,
                progressBarViewHeight: 6)
        }
    }
}
