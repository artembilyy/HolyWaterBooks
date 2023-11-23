//
//  BottomCollectionViewCell.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterUI

final class BottomCollectionViewCell: UICollectionViewCell, IdentifiableCell {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        return stackView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.text = "The Cristmas Surprise"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .blue
        label.numberOfLines = 0
        return label
    }()

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 16
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: topAnchor),
            stackView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(
                equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(
                equalTo: bottomAnchor)
        ])
    }
}
