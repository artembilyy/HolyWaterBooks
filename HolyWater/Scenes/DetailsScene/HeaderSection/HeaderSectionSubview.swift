//
//  HeaderSectionSubview.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import HolyWaterUI

final class HeaderSectionSubview: UIView {

    private let titleLabel: UILabel = .init()
    private let secondaryLabel: UILabel = .init()
    private let stackView: UIStackView = .init()

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
        setupConstraints()
    }

    func set(title: String, secondaryTitle: String) {
        titleLabel.text = title
        secondaryLabel.text = secondaryTitle
    }

    private func configureUI() {
        configureTitleLabel()
        configureSecondaryLabel()
        configureStackView()
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(secondaryLabel)
    }

    private func configureTitleLabel() {
        titleLabel.text = "22.2k"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .black
    }

    private func configureSecondaryLabel() {
        secondaryLabel.text = "Readers"
        secondaryLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        secondaryLabel.textColor = ThemeColor.lightGray.asUIColor()
    }

    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
    }
}

private extension HeaderSectionSubview {
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
