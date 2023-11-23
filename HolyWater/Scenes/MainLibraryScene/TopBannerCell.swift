//
//  TopBannerCell.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import HolyWaterServices
import UIKit

class TopBannerCell: UICollectionViewCell {

    let mainImageContainer: UIImageView = .init()

    static let identrifed = "TopBannerCell"

    private var imageLoadingManager: ImageLoadingManagerProtocol!

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageLoadingManager = ImageLoadingManager()

        layer.cornerRadius = 16
        clipsToBounds = true

        addSubview(mainImageContainer)
        mainImageContainer.frame = bounds
        mainImageContainer.contentMode = .scaleAspectFill
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(model: BookResponse.TopBannerSlideBook) {
        guard let url = model.cover else { return }
        Task {
            do {
                let result = try await imageLoadingManager.getImage(from: url)
                mainImageContainer.image = result
            } catch {
                mainImageContainer.image = UIImage(named: "PosterNil")
            }
        }
    }
}
