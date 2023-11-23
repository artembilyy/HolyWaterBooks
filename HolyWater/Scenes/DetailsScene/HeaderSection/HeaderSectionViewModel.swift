//
//  HeaderSectionViewModel.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import Foundation

final class HeaderSectionViewModel {

    private(set) var values: [String] = []

    init(
        readersCount: String,
        likesCount: String,
        quotesCount: String,
        genre: String) {
        values.append(readersCount)
        values.append(likesCount)
        values.append(quotesCount)
        values.append(genre)
    }
}
