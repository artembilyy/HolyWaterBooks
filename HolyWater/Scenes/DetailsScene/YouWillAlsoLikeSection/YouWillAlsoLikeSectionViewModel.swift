//
//  YouWillAlsoLikeSectionViewModel.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterServices

final class YouWillAlsoLikeSectionViewModel {

    typealias Dependencies =
        ImageLoadingWorkerContrainer

    private(set) var headerViewModel: HeaderViewModel
    private(set) var headerText: String = ""
    private(set) var books: [BookResponse.Book] = []
    private(set) var dependencies: Dependencies!

    init(
        headerViewModel: HeaderViewModel,
        books: [BookResponse.Book],
        dependencies: Dependencies) {
        self.headerViewModel = headerViewModel
        self.books = books
        self.dependencies = dependencies
    }
}
