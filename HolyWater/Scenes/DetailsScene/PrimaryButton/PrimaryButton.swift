//
//  PrimaryButton.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import HolyWaterUI

final class PrimaryButton: UIButton {

    private struct Style {
        let titleLabelFontSize: CGFloat
        let titleLabelText: String

        static func defaultStyle() -> Self {
            .init(
                titleLabelFontSize: 16,
                titleLabelText: "Read Now")
        }
    }

    private let style = Style.defaultStyle()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = bounds.height / 2
    }

    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ThemeColor.raspberryPink.asUIColor()
        setTitle(style.titleLabelText, for: .normal)

        titleLabel?.font = UIFont.systemFont(
            ofSize: style.titleLabelFontSize,
            weight: .heavy)
        titleLabel?.textColor = .white
    }
}
