//
//  UIColor+Image.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import UIKit

public extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
