//
//  LibraryViewController+DiffableDataSource.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import HolyWaterServices
import UIKit

extension LibraryViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<MainSection, AnyHashable>
    typealias Snapshot = NSDiffableDataSourceSnapshot<MainSection, AnyHashable>

    func setupDataSource() {
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            guard let section = MainSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
            guard let topBannerBookCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TopBannerCell.identrifed,
                for: indexPath) as? TopBannerCell else { return UICollectionViewCell() }
            switch section {
            case .topBooks:
                if let model = item as? BookResponse.TopBannerSlideBook {
                    topBannerBookCell.configure(model: model)
                }
                return topBannerBookCell
            case .books:
                if let model = item as? BookResponse.Book {
//                    topBannerBookCell.configure(model: model)
//
//                    switch model.genre {
//
//                    }
                }
                return topBannerBookCell
            }
        }
    }

    func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.topBooks, .books])
        snapshot.appendItems(viewModel.outputs.topBannerBooks, toSection: .topBooks)

        if let fantasyBooks = viewModel.outputs.books["Fantasy"] {
            snapshot.appendItems(fantasyBooks, toSection: .books)
        }

        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
