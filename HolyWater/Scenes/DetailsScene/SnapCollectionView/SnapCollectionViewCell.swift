//
//  SnapCollectionViewCell.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import HolyWaterUI

final class SnapCollectionViewCell: UICollectionViewCell, IdentifiableCell {

    private struct Style {
        let backgroundColor: ColorConvertible
        let cornerRadius: CGFloat

        static func defaultStyle() -> Self {
            .init(
                backgroundColor: ThemeColor.silver,
                cornerRadius: 16)
        }
    }

    private let style = Style.defaultStyle()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = style.backgroundColor.asUIColor()
        contentView.layer.cornerRadius = style.cornerRadius
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
