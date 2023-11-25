//
//  Optional+isNil.swift
//  HolyWaterUI
//
//  Created by Артем Билый on 25.11.2023.
//

extension Optional {
    public var isNil: Bool {
        switch self {
        case .none:
            return true
        case .some:
            return false
        }
    }
}
