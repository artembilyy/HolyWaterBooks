//
//  TopBannerCell.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import HolyWaterServices
import HolyWaterUI

final class TopBannerCell: UICollectionViewCell, IdentifiableCell {

    private let mainImageContainer: UIImageView = .init()
    private let loadingIndicator: LoadingIndicator = .init()
    var viewModel: TopBannerCellViewModel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = 16
        clipsToBounds = true

        mainImageContainer.frame = bounds
        mainImageContainer.contentMode = .scaleAspectFill

        addSubview(mainImageContainer)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageContainer.image = nil
    }

    func configure(indexPath: IndexPath) {
        loadingIndicator.install(on: mainImageContainer, with: .large)
        guard let url = viewModel.topBooks[indexPath.item].cover else { return }
        Task {
            /// added for throttling effect
            try await Task.sleep(seconds: 0.5)
            do {
                let image = try await viewModel
                    .dependencies
                    .imageLoadingManagerWorker
                    .getImage(from: url)
                mainImageContainer.image = image
                loadingIndicator.stopAnimating()
            } catch {
                mainImageContainer.image = UIImage(systemName: "trash")
                loadingIndicator.stopAnimating()
            }
        }
    }
}
