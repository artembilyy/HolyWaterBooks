//
//  TopBannerCellViewModel.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterServices

final class TopBannerCellViewModel {

    private(set) var topBooks: [BookResponse.TopBannerSlideBook]

    private(set) var dependencies: Dependencies

    init(
        topBooks: [BookResponse.TopBannerSlideBook],
        dependencies: Dependencies) {
        self.topBooks = topBooks
        self.dependencies = dependencies
    }
}
