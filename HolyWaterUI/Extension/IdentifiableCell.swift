//
//  IdentifiableCell.swift
//  HolyWaterUI
//
//  Created by Артем Билый on 22.11.2023.
//

public protocol IdentifiableCell {}
// MARK: - Allow us to not write identifier for each section
extension IdentifiableCell {
    public static var identifier: String {
        String(describing: Self.self)
    }
}
