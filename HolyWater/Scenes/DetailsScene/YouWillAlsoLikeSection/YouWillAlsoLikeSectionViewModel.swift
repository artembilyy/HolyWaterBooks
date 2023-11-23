//
//  YouWillAlsoLikeSectionViewModel.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterServices

final class YouWillAlsoLikeSectionViewModel {

    private(set) var headerViewModel: HeaderViewModel
    private(set) var headerText: String = ""
    private(set) var books: [BookResponse.Book] = []

    init(
        headerViewModel: HeaderViewModel,
        books: [BookResponse.Book]) {
        self.headerViewModel = headerViewModel
        self.books = books
    }
}
