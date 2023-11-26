//
//  YouwWillAlsoLikeSectionViewModelBuilder.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterServices

final class YouWillAlsoLikeSectionViewModelBuilder {

    typealias Dependencies =
        ImageLoadingWorkerContrainer

    private var headerText: String = ""
    private var books: [BookResponse.Book] = []
    private var dependencies: Dependencies!

    func set(headerText: String) -> Self {
        self.headerText = headerText
        return self
    }

    func set(books: [BookResponse.Book]) -> Self {
        self.books = books
        return self
    }

    func set(dependencies: Dependencies) -> Self {
        self.dependencies = dependencies
        return self
    }

    func build() -> YouWillAlsoLikeSectionViewModel {
        let headerViewModel = HeaderViewModelBuilder()
            .set(title: headerText)
            .set(textColor: .black)
            .build()

        return .init(
            headerViewModel: headerViewModel,
            books: books,
            dependencies: dependencies)
    }
}
