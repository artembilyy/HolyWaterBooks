//
//  SnapCollectionView.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import HolyWaterUI

final class SnapCollectionView: UIView {

    private let style = Style.defaultStyle()

    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = SnapLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.register(
            SnapCollectionViewCell.self,
            forCellWithReuseIdentifier: SnapCollectionViewCell.identifier)
        return collectionView
    }()

    private lazy var backgroundImageView: UIImageView = {
        $0.image = style.backgroundImageView
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alpha = style.backgroundImageViewAlpha
        return $0
    }(UIImageView())

    private let titleLabel: UILabel = .init()
    private let secondaryLabel: UILabel = .init()
    private let gradient: CAGradientLayer = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        setupBackgroundView()
        configureTitleLabel()
        configureSecondaryLabel()
        configureGradient()

        addSubviews([collectionView, titleLabel, secondaryLabel])
    }

    private func setupBackgroundView() {
        let firstLayer = CALayer()
        firstLayer.backgroundColor = UIColor.black.cgColor
        firstLayer.opacity = 0.7
        firstLayer.frame = backgroundImageView.bounds
        firstLayer.frame.size.width = frame.width
        layer.addSublayer(firstLayer)

        addSubview(backgroundImageView)

        gradient.frame = backgroundImageView.bounds
        gradient.frame.size.width = frame.width
        layer.addSublayer(gradient)

        let secondLayer = CALayer()
        secondLayer.backgroundColor = ThemeColor.byzantium.asCGColor()
        secondLayer.opacity = 1
        secondLayer.frame = backgroundImageView.bounds
        secondLayer.frame.size.width = frame.width
        secondLayer.compositingFilter = "multiplyBlendMode"
        layer.addSublayer(secondLayer)
    }

    private func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "If It’s Only Love"
        titleLabel.font = UIFont.systemFont(
            ofSize: style.titleLabelFontSize,
            weight: .bold)
        titleLabel.textColor = UIColor.white.withAlphaComponent(1)
    }

    private func configureSecondaryLabel() {
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        secondaryLabel.text = "Zoey Evers"
        secondaryLabel.font = UIFont.systemFont(
            ofSize: style.secondaryLabelFontSize,
            weight: .bold)
        secondaryLabel.textColor = UIColor.white.withAlphaComponent(0.8)
    }

    private func configureGradient() {
        gradient.type = .axial
        gradient.colors = [
            UIColor.black.withAlphaComponent(1).cgColor,
            UIColor.black.withAlphaComponent(0).cgColor
        ]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.opacity = 0.5
    }
}

extension SnapCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SnapCollectionViewCell.identifier,
                for: indexPath) as? SnapCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        return cell
    }
}

private extension SnapCollectionView {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor),
            backgroundImageView.topAnchor.constraint(
                equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(
                equalTo: bottomAnchor),

            secondaryLabel.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            secondaryLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -40),

            titleLabel.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(
                equalTo: secondaryLabel.topAnchor,
                constant: -4),

            collectionView.leadingAnchor.constraint(
                equalTo: backgroundImageView.leadingAnchor),
            collectionView.trailingAnchor.constraint(
                equalTo: backgroundImageView.trailingAnchor),
            collectionView.bottomAnchor.constraint(
                equalTo: titleLabel.topAnchor,
                constant: -16),
            collectionView.heightAnchor.constraint(
                equalToConstant: 250)
        ])
    }
}
