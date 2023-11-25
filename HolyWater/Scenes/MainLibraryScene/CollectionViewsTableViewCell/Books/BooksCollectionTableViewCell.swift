//
//  BooksCollectionTableViewCell.swift
//  HolyWater
//
//  Created by Артем Билый on 24.11.2023.
//

import HolyWaterUI

final class BooksCollectionTableViewCell: UITableViewCell, IdentifiableCell {

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
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.backgroundColor = .clear

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            BookCell.self,
            forCellWithReuseIdentifier: BookCell.identifier)
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

//    var viewModel: TableViewCellViewModel!

    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - UI Setup

extension BooksCollectionTableViewCell {

    private func setupUI() {
        collectionView.dataSource = self

        addSubview(collectionView)

        collectionView.frame = bounds
    }
}

extension BooksCollectionTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        DetailsViewModel.data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCell.identifier, for: indexPath) as? BookCell else { return UICollectionViewCell() }
        let data = DetailsViewModel.data[indexPath.item]
        cell.configureCell(with: data)
        return cell
    }
}

extension BooksCollectionTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 200)
    }
}
