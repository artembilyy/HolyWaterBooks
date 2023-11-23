//
//  HeaderViewModelBuilder.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import UIKit

final class HeaderViewModelBuilder {

    private var title: String = ""
    private var textColor: UIColor = .clear

    func set(title: String) -> Self {
        self.title = title
        return self
    }

    func set(textColor: UIColor) -> Self {
        self.textColor = textColor
        return self
    }

    func build() -> HeaderViewModel {
        .init(
            title: title,
            textColor: textColor)
    }
}
