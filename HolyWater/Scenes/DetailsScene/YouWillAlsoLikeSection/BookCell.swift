//
//  BookCell.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterServices
import HolyWaterUI

final class BookCell: UICollectionViewCell, IdentifiableCell {

    private let label: UILabel = .init()
    private let imageView: UIImageView = .init()
    private var loadingIndicator: LoadingIndicator? = .init()

    var viewModel: BookCellViewModel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }

    func configureCell(indexPath: IndexPath) {
        let book = viewModel.books[indexPath.item]
        loadingIndicator?.install(on: imageView, with: .large)
        guard let url = book.coverURL?.absoluteString else { return }
        Task {
            loadingIndicator?.startAnimating()
            do {
                let image = try await viewModel
                    .dependencies
                    .imageLoadingManagerWorker
                    .getImage(from: url)
                imageView.image = image
                loadingIndicator?.stopAnimating()
            } catch {
                imageView.image = UIImage(systemName: "trash")
                loadingIndicator?.stopAnimating()
            }
        }

        label.text = book.name
    }

    private func configureUI() {
        configureLabel()
        configureImageView()

        addSubview(imageView)
        addSubview(label)
    }

    private func configureLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = ThemeColor.jetBlack.asUIColor()
        label.numberOfLines = 0
    }

    private func configureImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = ThemeColor.silver.asUIColor()
        imageView.layer.cornerRadius = 16
    }
}

private extension BookCell {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(
                equalTo: topAnchor),
            imageView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(
                equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(
                equalTo: imageView.widthAnchor,
                multiplier: 1.25),

            label.topAnchor.constraint(
                equalTo: imageView.bottomAnchor,
                constant: 4),
            label.leadingAnchor.constraint(
                equalTo: imageView.leadingAnchor),
            label.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])
    }
}
