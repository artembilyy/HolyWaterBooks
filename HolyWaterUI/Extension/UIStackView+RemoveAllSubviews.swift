//
//  UIStackView+RemoveAllSubviews.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import Foundation

public extension UIStackView {
    func removeAllArrangeSubviews() {
        for view in self.arrangedSubviews {
            self.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
