//
//  YouWillAlsoLikeSectionView.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import HolyWaterUI

final class YouWillAlsoLikeSectionView: UIView {

    var viewModel: YouWillAlsoLikeSectionViewModel? {
        didSet {
            configureUI()
        }
    }

    private var headerView: HeaderView = .init()

    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 8
        collectionViewLayout.minimumInteritemSpacing = 8
        collectionViewLayout.itemSize = CGSize(width: 120, height: 190)
        collectionViewLayout.sectionInset.left = 16
        collectionViewLayout.sectionInset.right = 16
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.register(cellType: BookCell.self)
        return collectionView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        addSubview(headerView)
        addSubview(collectionView)
    }

    private func configureUI() {
        guard let viewModel else { return }
        if let title = headerView.viewModel?.title, title.isEmpty.not {
            headerView.viewModel = viewModel.headerViewModel
            collectionView.reloadData()
        }
    }
}

extension YouWillAlsoLikeSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.books.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel else {
            return UICollectionViewCell()
        }
        let cell: BookCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.viewModel = .init(books: viewModel.books, dependencies: viewModel.dependencies)
        cell.viewModel?.textStyle.accept(.details)
        cell.configureCell(indexPath: indexPath)
        return cell
    }
}

private extension YouWillAlsoLikeSectionView {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(
                equalTo: topAnchor),
            headerView.leadingAnchor.constraint(
                equalTo: leadingAnchor),

            collectionView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: -16),
            collectionView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: 16),
            collectionView.topAnchor.constraint(
                equalTo: headerView.bottomAnchor,
                constant: 16),
            collectionView.heightAnchor.constraint(
                equalToConstant: 210),
            collectionView.bottomAnchor.constraint(
                equalTo: bottomAnchor)
        ])
    }
}
