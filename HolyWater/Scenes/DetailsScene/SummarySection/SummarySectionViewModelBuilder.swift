//
//  SummarySectionViewModelBuilder.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import Foundation

final class SummarySectionViewModelBuilder {

    private var headerText: String = ""
    private var descriptionText: String = ""

    func set(headerText: String) -> Self {
        self.headerText = headerText
        return self
    }

    func set(descriptionText: String) -> Self {
        self.descriptionText = descriptionText
        return self
    }

    func build() -> SummarySectionViewModel {
        return SummarySectionViewModel(
            headerText: headerText,
            descriptionText: descriptionText)
    }
}
