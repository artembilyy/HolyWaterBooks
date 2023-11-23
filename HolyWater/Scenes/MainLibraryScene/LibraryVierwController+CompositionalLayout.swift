//
//  LibraryVierwController+CompositionalLayout.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import UIKit

extension LibraryViewController {
    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionNumber, _ -> NSCollectionLayoutSection? in
            guard let self else { return nil }
            switch sectionNumber {
            case 0:
                return self.createMoviesLayout()
            default:
                return self.createMoviesLayout()
            }
        }
    }

    func createMoviesLayout() -> NSCollectionLayoutSection? {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets.leading = 16
        item.contentInsets.trailing = 16
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.47))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets.top = 20
        return section
    }
}
