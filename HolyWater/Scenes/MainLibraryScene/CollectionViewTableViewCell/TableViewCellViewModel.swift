//
//  TableViewCellViewModel.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import Foundation

final class TableViewCellViewModel {

    var topBannerCellViewModel: TopBannerCellViewModel

    init(topBannerCellViewModel: TopBannerCellViewModel) {
        self.topBannerCellViewModel = topBannerCellViewModel
    }
}
