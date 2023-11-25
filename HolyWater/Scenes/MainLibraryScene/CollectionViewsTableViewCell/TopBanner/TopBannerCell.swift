//
//  TopBannerCell.swift
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
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGesture.delegate = self
        self.addGestureRecognizer(panGesture)
    }

    @objc private func handlePan(_ pan: UIPanGestureRecognizer) {
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
        guard let url = viewModel.topBooks[indexPathItem].cover else { return }
        Task {
            loadingIndicator?.startAnimating()
            do {
                let image = try await viewModel
                    .dependencies
                    .imageLoadingManagerWorker
                    .getImage(from: url)
                mainImageContainer.image = image
                loadingIndicator?.stopAnimating()
            } catch {
                mainImageContainer.image = UIImage(systemName: "trash")
                loadingIndicator?.stopAnimating()
            }
        }
    }
}

extension TopBannerCell: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
