//
//  UIView+Subviews.swift
//  HolyWater
//
//  Created by Артем Билый on 20.11.2023.
//

public extension UIView {

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
}
