//
//  TopBooksCollectionTableViewCell+AutoScrollLayout.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import HolyWaterUI

extension TopBannerCollectionView {

    func createCompositionalLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { [weak self] _, _ in
            self?.createTopBannerLayout()
        }
    }

    private func createTopBannerLayout() -> NSCollectionLayoutSection? {
        let sectionMargin = 8.0

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)

        layoutItem.contentInsets.leading = 8
        layoutItem.contentInsets.trailing = 8

        let pageWidth = collectionView.bounds.width - sectionMargin * 2
        let layoutGroupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(pageWidth),
            heightDimension: .estimated(frame.height))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered

        layoutSection.visibleItemsInvalidationHandler = { [weak self] _, point, _ in
            guard let self, let viewModel else { return }

            guard
                var page = Int(exactly: (point.x + sectionMargin) / pageWidth),
                let maxIndex = viewModel.topBooks.indices.max()
            else {
                return
            }

            currentAutoScrollIndex = page
            if page == maxIndex {
                page = 1
                currentAutoScrollIndex = page
            } else if page == 0 {
                page = maxIndex - 1
                currentAutoScrollIndex = page
            }

            let realPage = page - 1

            if pageControl.currentPage != realPage {
                pageControl.currentPage = realPage
                let indexPath = IndexPath(item: page, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            }

            configAutoScroll()
        }

        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        return layoutSection
    }
}
