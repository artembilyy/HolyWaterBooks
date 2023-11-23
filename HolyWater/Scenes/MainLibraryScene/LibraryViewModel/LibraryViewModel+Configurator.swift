//
//  LibraryViewModel+Configurator.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterServices

protocol LibraryViewModelConfigurator {
    func configureTopBannerCellViewModel(
        items: [BookResponse.TopBannerSlideBook]) -> TopBannerCellViewModel
}

extension LibraryViewModel {
    func configureTopBannerCellViewModel(
        items: [BookResponse.TopBannerSlideBook]) -> TopBannerCellViewModel {
        .init(
            topBooks: items,
            dependencies: dependencies)
    }
}
