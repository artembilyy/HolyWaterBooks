//
//  SnapCollectionViewModelBuilder.swift
//  HolyWater
//
//  Created by Артем Билый on 26.11.2023.
//

import HolyWaterServices

final class SnapCollectionViewModelBuilder {

    typealias Dependencies =
        ImageLoadingWorkerContrainer

    private var books: [BookResponse.Book] = []
    var dependencies: Dependencies!

    func set(books: [BookResponse.Book]) -> Self {
        self.books = books
        return self
    }

    func set(dependencies: Dependencies) -> Self {
        self.dependencies = dependencies
        return self
    }

    func build() -> SnapCollectionViewModel {
        return .init(books: books, dependencies: dependencies)
    }
}
