//
//  Bool+State.swift
//  HolyWater
//
//  Created by Артем Билый on 20.11.2023.
//

public extension Bool {

    var not: Bool {
        return !self
    }

    var isFalse: Bool {
        return self == false
    }

    var isTrue: Bool {
        return self == true
    }
}
