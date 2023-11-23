//
//  YouwWillAlsoLikeSectionViewModelBuilder.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterServices

final class YouWillAlsoLikeSectionViewModelBuilder {

    private var headerText: String = ""
    private var books: [BookResponse.Book] = []

    func set(headerText: String) -> Self {
        self.headerText = headerText
        return self
    }

    func set(books: [BookResponse.Book]) -> Self {
        self.books = books
        return self
    }

    func build() -> YouWillAlsoLikeSectionViewModel {
        let headerViewModel = HeaderViewModelBuilder()
            .set(title: headerText)
            .set(textColor: .black)
            .build()

        return .init(
            headerViewModel: headerViewModel,
            books: books)
    }
}
