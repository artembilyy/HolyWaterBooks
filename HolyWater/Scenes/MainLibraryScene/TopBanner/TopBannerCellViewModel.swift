//
//  TopBannerCellViewModel.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterServices

final class TopBannerCellViewModel {

    private(set) var topBooks: [BookResponse.TopBannerSlideBook] {
        didSet {
            if topBooks.count > 1, let lastBook = topBooks.last {
                topBooks.insert(lastBook, at: 0)
                topBooks.append(topBooks[1])
            }
        }
    }

    private(set) var dependencies: Dependencies

    init(
        topBooks: [BookResponse.TopBannerSlideBook],
        dependencies: Dependencies) {
        self.topBooks = topBooks
        self.dependencies = dependencies
    }
}
