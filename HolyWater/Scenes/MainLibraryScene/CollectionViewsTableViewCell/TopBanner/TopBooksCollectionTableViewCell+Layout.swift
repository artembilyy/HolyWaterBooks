//
//  TopBooksCollectionTableViewCell+Layout.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import HolyWaterUI

extension TopBooksCollectionTableViewCell {

    func createCompositionalLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { [weak self] _, _ in
            guard let self else { return nil }

            return self.createTopBannerLayout()
        }
    }

    func createTopBannerLayout() -> NSCollectionLayoutSection? {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets.leading = 16
        item.contentInsets.trailing = 16

        let pageWidth = collectionView.bounds.width - 8 * 2

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(pageWidth),
            heightDimension: .fractionalWidth(0.47))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        section.visibleItemsInvalidationHandler = { [weak self] visibleItems, point, _ in
            guard let self else { return }
            guard let currentIndex = visibleItems.last?.indexPath.item,
                  visibleItems.last?.indexPath.section == 0 else {
                return
            }

            if var page = Int(exactly: (point.x + 8) / pageWidth) {
                let maxIndex = self.viewModel.topBooks.indices.max()!
                self.currentAutoScrollIndex = page

                if page == maxIndex {
                    /// When at last item, need to change to array[1], so it can continue to scroll right or left
                    page = 1
                    self.currentAutoScrollIndex = page
                } else if page == 0 {
                    /// When at fist item, need to change to array[3], so it can continue to scroll right or left
                    page = maxIndex - 1
                    self.currentAutoScrollIndex = page
                }

                /// Because we add a data in array
                let realPage = page - 1

                if self.pageControl.currentPage != realPage {
                    self.pageControl.currentPage = realPage
                    self.collectionView.scrollToItem(at: IndexPath(item: page, section: 0), at: .left, animated: false)
                }

                self.configAutoScroll()
            }
//            print("PAGE NOW \(page)")
//            print("Current POINT X \(point.x)")
//            print("Current INDEX \(currentIndex)")

        }

        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets.top = 20
        return section
    }
}

//                                    self.collectionView.scrollToItem(at: IndexPath(item: page, section: 0), at: .left, animated: false)

//            guard self.isHorizontalScrollingEnabled else { return }

//            if point.x <= .zero {
//                self.collectionView.scrollToItem(
//                    at: .init(row: viewModel.topBooks.count - 2, section: 0),
//                    at: .right,
//                    animated: false
//                )
//            }
//
//            if point.x >= (pageWidth - section.interGroupSpacing) * CGFloat(self.viewModel.topBooks.count - 1) {
//                self.collectionView.scrollToItem(
//                    at: .init(row: 1, section: 0),
//                    at: .right,
//                    animated: false
//                )
//            }

//        section.visibleItemsInvalidationHandler = { visibleItems, point, environment in
//            if var page = Int(exactly: (point.x + 16) / pageWidth) {
//                let maxIndex = self.viewModel.topBooks.indices.max()!
//                self.currentAutoScrollIndex = page
//
//                /// Setup for infinite scroll; we had modify the data array to be [C, A, B, C, A]
//                if page == maxIndex {
//                    /// When at last item, need to change to array[1], so it can continue to scroll right or left
//                    page = 1
//                    self.currentAutoScrollIndex = page
//                } else if page == 0 {
//                    /// When at fist item, need to change to array[3], so it can continue to scroll right or left
//                    page = maxIndex - 1
//                    print(page)
//                    self.currentAutoScrollIndex = page
//                }
//
//                /// Because we add a data in array
//                let realPage = page - 1
//
//                /// Update page control and cell only when page changed
//                if self.pageControl.currentPage != realPage {
//                    self.pageControl.currentPage = realPage
//                    self.collectionView.scrollToItem(at: IndexPath(item: page, section: 0), at: .left, animated: false)
//                }
//                self.configAutoScroll()
//            }
//        }
