//
//  MainStackViewModel.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import Foundation

final class MainStackViewModel {

    let summarySectionViewModel: SummarySectionViewModel
    let youWillAlsoLikeSectionView: YouWillAlsoLikeSectionViewModel
    let headerSectionViewModel: HeaderSectionViewModel

    init(
        summarySectionViewModel: SummarySectionViewModel,
        youWillAlsoLikeSectionView: YouWillAlsoLikeSectionViewModel,
        headerSectionViewModel: HeaderSectionViewModel) {
        self.summarySectionViewModel = summarySectionViewModel
        self.youWillAlsoLikeSectionView = youWillAlsoLikeSectionView
        self.headerSectionViewModel = headerSectionViewModel
    }
}
