//
//  TopBooksCollectionTableViewCell+LAutoScrollLayout.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import HolyWaterUI

extension TopBooksCollectionTableViewCell {

    func createCompositionalLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { [weak self] _, _ in
            self?.createTopBannerLayout()
        }
    }

    func createTopBannerLayout() -> NSCollectionLayoutSection? {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets.leading = 16
        item.contentInsets.trailing = 16
        let pageWidth = collectionView.bounds.width - 8 * 2 // !!
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(pageWidth),
            heightDimension: .fractionalWidth(0.47))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        section.visibleItemsInvalidationHandler = { [weak self] _, point, _ in
            guard let self, let viewModel else { return }

            if var page = Int(exactly: (point.x + 8) / pageWidth) { // !!
                let maxIndex = viewModel.topBooks.indices.max()!
                self.currentAutoScrollIndex = page
                if page == maxIndex {
                    page = 1
                    self.currentAutoScrollIndex = page
                } else if page == 0 {
                    page = maxIndex - 1
                    self.currentAutoScrollIndex = page
                }

                let realPage = page - 1

                if self.pageControl.currentPage != realPage {
                    self.pageControl.currentPage = realPage
                    let indexPath: IndexPath = .init(item: page, section: 0)
                    self.collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
                }

                self.configAutoScroll()
            }
        }

        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets.top = 20
        return section
    }
}
