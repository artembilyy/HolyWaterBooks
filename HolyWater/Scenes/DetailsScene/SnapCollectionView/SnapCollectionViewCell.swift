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

    let loadingIndicator: LoadingIndicator? = .init()

    var viewModel: SnapCollectionViewCellViewModel?

    private let style = Style.defaultStyle()
    private let imageContainer: UIImageView = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = style.cornerRadius

        contentView.addSubview(imageContainer)
        imageContainer.frame = bounds
        contentView.clipsToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageContainer.image = nil
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell() {
        loadingIndicator?.install(on: imageContainer, with: .large)
        self.loadingIndicator?.startAnimating()
        viewModel?.loadImage { [weak self] image in
            guard let self else { return }
            if let image {
                self.imageContainer.image = image
                self.loadingIndicator?.stopAnimating()
            } else {
                self.imageContainer.image = UIImage(systemName: "trash")
                self.loadingIndicator?.stopAnimating()
            }
        }
    }
}
