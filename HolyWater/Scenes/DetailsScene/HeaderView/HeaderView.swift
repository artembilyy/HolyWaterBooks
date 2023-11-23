//
//  HeaderView.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import UIKit

final class HeaderView: UIView {

    var viewModel: HeaderViewModel? {
        didSet {
            configureUI()
        }
    }

    private let label: UILabel = .init()

    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }

    private func configureUI() {
        guard let viewModel else { return }
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

        label.text = viewModel.title
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
}

private extension HeaderView {
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
