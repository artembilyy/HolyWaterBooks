//
//  TopBannerCollectionCell.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import HolyWaterServices
import HolyWaterUI

protocol InfiniteAutoScrollViewCellDelegate: AnyObject {
    func invalidateTimer()
}

final class TopBannerCell: UICollectionViewCell, IdentifiableCell {

    private let mainImageContainer: UIImageView = .init()
    private var loadingIndicator: LoadingIndicator? = .init()
    var viewModel: TopBannerCellViewModel!

    weak var delegate: InfiniteAutoScrollViewCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = 16
        clipsToBounds = true

        mainImageContainer.frame = bounds
        mainImageContainer.contentMode = .scaleAspectFill

        addSubview(mainImageContainer)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        panGesture.delegate = self
        self.addGestureRecognizer(panGesture)
    }

    @objc
    private func handlePan() {
        delegate?.invalidateTimer()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageContainer.image = nil
        loadingIndicator = nil
    }

    func configure(indexPathItem: Int) {
        loadingIndicator?.install(on: mainImageContainer, with: .large)
        loadingIndicator?.startAnimating()
        viewModel.loadImage(for: indexPathItem) { [weak self] image in
            guard let self else { return }
            if let image {
                self.mainImageContainer.image = image
                self.loadingIndicator?.stopAnimating()
            } else {
                self.mainImageContainer.image = UIImage(systemName: "trash")
                self.loadingIndicator?.stopAnimating()
            }
        }
    }
}

extension TopBannerCell: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
