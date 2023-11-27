//
//  UIColor+Image.swift
//  HolyWaterUI
//
//  Created by Artem Tkachenko on 25.11.2023.
//

import UIKit

public extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
