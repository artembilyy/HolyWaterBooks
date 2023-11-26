//
//  SnapCollectionViewModel.swift
//  HolyWater
//
//  Created by Артем Билый on 26.11.2023.
//

import HolyWaterServices

final class SnapCollectionViewModel {

    typealias Dependencies =
        ImageLoadingWorkerContrainer

    let books: [BookResponse.Book]
    var dependencies: Dependencies

    init(
        books: [BookResponse.Book],
        dependencies: Dependencies) {

        self.books = books
        self.dependencies = dependencies
    }
}
