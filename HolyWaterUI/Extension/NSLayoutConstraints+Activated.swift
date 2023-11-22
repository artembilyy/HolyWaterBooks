//
//  NSLayoutConstraints+Activated.swift
//  HolyWater
//
//  Created by Артем Билый on 20.11.2023.
//

public extension NSLayoutConstraint {

    @discardableResult
    func activated() -> Self {
        self.isActive = true
        return self
    }

    @discardableResult
    func deactivated() -> Self {
        self.isActive = false
        return self
    }
}
