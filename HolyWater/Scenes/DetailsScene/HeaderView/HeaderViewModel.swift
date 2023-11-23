//
//  HeaderViewModel.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import UIKit

final class HeaderViewModel {

    private(set) var title: String = ""
    private(set) var textColor: UIColor = .clear

    init(title: String, textColor: UIColor) {
        self.title = title
        self.textColor = textColor
    }
}
