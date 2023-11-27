//
//  BookCell.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterServices
import HolyWaterUI
import RxSwift

final class BookCell: UICollectionViewCell, IdentifiableCell {

    var viewModel: BookCellViewModel? {
        didSet {
            bind()
        }
    }

    private var loadingIndicator: LoadingIndicator? = .init()

    private let label: UILabel = .init()
    private let imageView: UIImageView = .init()

    private let disposeBag: DisposeBag = .init()

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

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        label.text = ""
        loadingIndicator = nil
    }

    func configureCell(indexPath: IndexPath) {
        loadingIndicator?.install(on: imageView, with: .large)
        self.loadingIndicator?.startAnimating()
        guard let book = viewModel?.books[indexPath.item] else { return }

        viewModel?.loadImage(for: book, completion: { [weak self] image in
            guard let self else { return }
            if let image {
                self.imageView.image = image
                self.loadingIndicator?.stopAnimating()
            } else {
                self.imageView.image = UIImage(systemName: "trash")
                self.loadingIndicator?.stopAnimating()
            }
            label.text = book.name
        })

    }

    private func configureUI() {
        configureLabel()
        configureImageView()

        addSubview(imageView)
        addSubview(label)
    }

    private func configureLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = NunitoSans.semiBold(16).font
        label.numberOfLines = 0
    }

    private func configureImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = ThemeColor.silver.asUIColor()
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
    }

    private func bind() {
        viewModel?
            .textStyle
            .subscribe(onNext: { [weak self] textStyle in
                self?.label.textColor = textStyle.color
            })
            .disposed(by: disposeBag)
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
