//
//  LibraryViewController+Layout.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import UIKit

extension LibraryViewController {

    enum Section {
        case banners, books
    }

    func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout())
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.frame = view.bounds
        collectionView.contentInset.bottom = 96
        return collectionView
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, _ -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                return self?.sectionLayout(for: .banners)
            } else {
                return self?.sectionLayout(for: .books)
            }
        }
    }

    private func sectionLayout(for sectionType: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize: NSCollectionLayoutSize
        let group: NSCollectionLayoutGroup
        let section: NSCollectionLayoutSection

        switch sectionType {
        case .banners:
            groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(0.46))
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            section = NSCollectionLayoutSection(group: group)
            section.contentInsets.top = 20
            section.contentInsets.bottom = 40
            section.orthogonalScrollingBehavior = .groupPagingCentered
        case .books:
            item.contentInsets.trailing = 8
            groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(120),
                heightDimension: .estimated(190))
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(26))

            section = NSCollectionLayoutSection(group: group)
            section.contentInsets.leading = 16
            section.contentInsets.top = 14
            section.contentInsets.bottom = 24
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            section.boundarySupplementaryItems = [header]
        }
        return section
    }

}
