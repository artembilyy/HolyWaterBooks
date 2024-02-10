//
//  CollectionViewHeader.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterUI

final class CollectionViewHeader: UICollectionReusableView, IdentifiableCell {

    private let label = UILabel()

    var title: String = "" {
        didSet {
            label.text = title
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = NunitoSans.bold(20).font
        label.textColor = .white
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(
                equalTo: topAnchor),
            label.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            label.trailingAnchor.constraint(
                equalTo: trailingAnchor),
            label.bottomAnchor.constraint(
                equalTo: bottomAnchor)
        ])
    }
}
