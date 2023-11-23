//
//  SummarySectionViewModel.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import Foundation

final class SummarySectionViewModel {

    private(set) var headerText: String = ""
    private(set) var descriptionText: String = ""

    init(
        headerText: String,
        descriptionText: String) {
        self.headerText = headerText
        self.descriptionText = descriptionText
    }
}
