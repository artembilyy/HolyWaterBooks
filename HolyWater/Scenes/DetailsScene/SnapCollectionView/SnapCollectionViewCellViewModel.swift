//
//  SnapCollectionViewCellViewModel.swift
//  HolyWater
//
//  Created by Артем Билый on 26.11.2023.
//

import HolyWaterServices

final class SnapCollectionViewCellViewModel {

    typealias Dependencies =
        ImageLoadingWorkerContrainer

    let book: BookResponse.Book
    let dependencies: Dependencies

    init(book: BookResponse.Book, dependencies: Dependencies) {
        self.book = book
        self.dependencies = dependencies
    }
}
