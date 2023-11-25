//
//  BookCellViewModel.swift
//  HolyWater
//
//  Created by Артем Билый on 25.11.2023.
//

import HolyWaterServices

final class BookCellViewModel {

    private(set) var books: [BookResponse.Book]

    private(set) var dependencies: Dependencies

    init(
        books: [BookResponse.Book],
        dependencies: Dependencies) {
        self.books = books
        self.dependencies = dependencies
    }
}
