//
//  HeaderSectionSubview.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import HolyWaterUI

final class HeaderSectionSubview: UIView {

    private let titleLabel = UILabel()
    private let secondaryLabel = UILabel()
    private let stackView = UIStackView()

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
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
    }

    private func configureSecondaryLabel() {
        secondaryLabel.text = "Readers"
        secondaryLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        secondaryLabel.textColor = ThemeColor.lightGray.asUIColor()
        secondaryLabel.textAlignment = .center
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
