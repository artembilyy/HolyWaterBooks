//
//  HeaderSectionViewModelBuilder.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import Foundation

final class HeaderSectionViewModelBuilder {

    private var readersCount: String = ""
    private var likesCount: String = ""
    private var quotesCount: String = ""
    private var genre: String = ""

    func set(readersCount: String) -> Self {
        self.readersCount = readersCount
        return self
    }

    func set(likesCount: String) -> Self {
        self.likesCount = likesCount
        return self
    }

    func set(quotesCount: String) -> Self {
        self.quotesCount = quotesCount
        return self
    }

    func set(genre: String) -> Self {
        self.genre = genre
        return self
    }

    func build() -> HeaderSectionViewModel {
        .init(
            readersCount: readersCount,
            likesCount: likesCount,
            quotesCount: quotesCount,
            genre: genre)
    }
}
