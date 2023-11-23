//
//  MainStackView.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterUI

final class MainStackView: UIView {

    var viewModel: MainStackViewModel? {
        didSet {
            configureViewModels()
        }
    }

    private let headerSection: HeaderSectionView = .init()
    private let summarySection: SummarySectionView = .init()
    private let youWillAlsoLikeSection: YouWillAlsoLikeSectionView = .init()
    private let readNowButton: PrimaryButton = .init()
    private let stackView: UIStackView = .init()
    private let bottomView: UIView = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }

    private func setupUI() {
        configureStackView()
        configureBottomView()
        renderData()

        addSubview(stackView)
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(bottomView)

        bottomView.addSubviews([headerSection, stackView, readNowButton])
    }

    private func renderData() {
        let renderData = [SeparatorView(), summarySection, SeparatorView(), youWillAlsoLikeSection]

        renderData.forEach { view in
            stackView.addArrangedSubview(view)
        }
    }

    private func configureViewModels() {
        guard let viewModel else { return }
        summarySection.viewModel = viewModel.summarySectionViewModel
        youWillAlsoLikeSection.viewModel = viewModel.youWillAlsoLikeSectionView
        headerSection.viewModel = viewModel.headerSectionViewModel
    }

    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fill
    }

    private func configureBottomView() {
        bottomView.backgroundColor = .white
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 22
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}

private extension MainStackView {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(
                equalTo: topAnchor),
            bottomView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(
                equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(
                equalTo: bottomAnchor),

            headerSection.topAnchor.constraint(
                equalTo: bottomView.topAnchor,
                constant: 20),
            headerSection.heightAnchor.constraint(
                equalToConstant: 36),
            headerSection.centerXAnchor.constraint(
                equalTo: bottomView.centerXAnchor),

            stackView.topAnchor.constraint(
                equalTo: headerSection.bottomAnchor,
                constant: 11),
            stackView.leadingAnchor.constraint(
                equalTo: bottomView.leadingAnchor,
                constant: 16),
            stackView.trailingAnchor.constraint(
                equalTo: bottomView.trailingAnchor,
                constant: -16),

            readNowButton.topAnchor.constraint(
                equalTo: stackView.bottomAnchor,
                constant: 24),
            readNowButton.centerXAnchor.constraint(
                equalTo: stackView.centerXAnchor),
            readNowButton.widthAnchor.constraint(
                equalToConstant: 278),
            readNowButton.heightAnchor.constraint(
                equalToConstant: 48),
            readNowButton.bottomAnchor.constraint(
                equalTo: bottomView.bottomAnchor)
        ])
    }
}
