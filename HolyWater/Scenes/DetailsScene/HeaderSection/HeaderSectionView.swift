//
//  HeaderSectionView.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import HolyWaterUI

final class HeaderSectionView: UIView {

    var viewModel: HeaderSectionViewModel? {
        didSet {
            configureUI()
        }
    }

    private let stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 40
        $0.alignment = .center
        $0.distribution = .fill
        return $0
    }(UIStackView())

    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }

    private func configureUI() {
        addSubview(stackView)
        translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubviews()
    }

    private func addArrangedSubviews() {
        guard let viewModel else { return }

        stackView.removeAllArrangeSubviews()

        HeaderSectionSubview
            .Style
            .allCases
            .enumerated()
            .forEach { index, style in
                let subview = HeaderSectionSubview()

                subview.set(
                    title: viewModel.values[index],
                    secondaryTitle: style.secondaryTitle)

                stackView.addArrangedSubview(subview)
            }
    }
}

private extension HeaderSectionView {
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
