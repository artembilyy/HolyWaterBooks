//
//  MainStackViewModelBuilder.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterServices

final class MainStackViewModelBuilder {

    private var readersCount: String = ""
    private var likesCount: String = ""
    private var quotesCount: String = ""
    private var genre: String = ""

    private var description: String = ""
    private var books: [BookResponse.Book] = []

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

    func set(description: String) -> Self {
        self.description = description
        return self
    }

    func set(books: [BookResponse.Book]) -> Self {
        self.books = books
        return self
    }

    func build() -> MainStackViewModel {
        let summarySectionViewModel = SummarySectionViewModelBuilder()
            .set(headerText: "Summary")
            .set(descriptionText: description)
            .build()

        let youWillAlsoLikeSectionView = YouWillAlsoLikeSectionViewModelBuilder()
            .set(headerText: "You will also like")
            .set(books: books)
            .build()

        let headerSectionViewModel = HeaderSectionViewModelBuilder()
            .set(readersCount: readersCount)
            .set(likesCount: likesCount)
            .set(quotesCount: quotesCount)
            .set(genre: genre)
            .build()

        return .init(
            summarySectionViewModel: summarySectionViewModel,
            youWillAlsoLikeSectionView: youWillAlsoLikeSectionView,
            headerSectionViewModel: headerSectionViewModel)
    }
}
