//
//  SummarySectionView.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import HolyWaterUI

final class SummarySectionView: UIView {

    var viewModel: SummarySectionViewModel? {
        didSet {
            configureUI()
        }
    }

    private let headerView: HeaderView = .init()
    private let stackView: UIStackView = .init()
    private let descriptionLabel: UILabel = .init()

    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }

    private func configureUI() {
        guard let viewModel else { return }
        configureStackView()
        configureDescriptionLabel()

        addSubview(stackView)
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(descriptionLabel)

        descriptionLabel.text = viewModel.descriptionText

        headerView.viewModel = HeaderViewModelBuilder()
            .set(title: viewModel.headerText)
            .set(textColor: .black)
            .build()
    }

    private func configureDescriptionLabel() {
        descriptionLabel.font = NunitoSans.semiBold(14).font
        descriptionLabel.textColor = ThemeColor.jetBlack.asUIColor()
        descriptionLabel.numberOfLines = 0
    }

    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
    }
}

private extension SummarySectionView {
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
