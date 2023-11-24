//
//  TopBooksCollectionTableViewCell.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterUI

final class TopBooksCollectionTableViewCell: UITableViewCell, IdentifiableCell {

    private let collectionViewLayout = UICollectionViewFlowLayout()

    lazy private var collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: collectionViewLayout)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    var viewModel: TopBannerCellViewModel!

    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.collectionView.reloadData()
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - UI Setup

extension TopBooksCollectionTableViewCell {

    private func setupUI() {
        collectionViewLayout.scrollDirection = .horizontal
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(
            TopBannerCell.self,
            forCellWithReuseIdentifier: TopBannerCell.identifier)

        collectionView.delegate = self
        collectionView.dataSource = self

        addSubview(collectionView)

        collectionView.frame = bounds

    }
}

extension TopBooksCollectionTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.topBooks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopBannerCell.identifier, for: indexPath) as? TopBannerCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel
        cell.configure(indexPath: indexPath)
        return cell
    }
}

extension TopBooksCollectionTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32
        return CGSize(width: collectionView.frame.width - 32, height: width * 0.47)
    }
}
