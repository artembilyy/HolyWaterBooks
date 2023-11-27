//
//  SeparatorView.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterUI

final class SeparatorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        heightAnchor.constraint(equalToConstant: 1).activated()
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ThemeColor.lightGray.asUIColor()
    }
}
