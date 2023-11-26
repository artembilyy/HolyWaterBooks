//
//  DetailsViewModel.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import HolyWaterServices

final class DetailsViewModel {

    typealias Dependencies =
        ImageLoadingWorkerContrainer

    let topSection: [BookResponse.Book]
    let bottomSection: [BookResponse.Book]
    let mainStackViewModel: MainStackViewModel
    let dependencies: Dependencies
    let snapCollectionViewModel: SnapCollectionViewModel

    init(
        topSection: [BookResponse.Book],
        bottomSection: [BookResponse.Book],
        dependencies: Dependencies) {
        self.topSection = topSection
        self.bottomSection = bottomSection
        self.dependencies = dependencies

        let mainBook = topSection.first

        self.mainStackViewModel = MainStackViewModelBuilder()
            .set(readersCount: mainBook?.views ?? "")
            .set(likesCount: mainBook?.likes ?? "")
            .set(quotesCount: mainBook?.quotes ?? "")
            .set(genre: mainBook?.genre ?? "")
            .set(description: mainBook?.summary ?? "")
            .set(books: bottomSection)
            .set(dependencies: dependencies)
            .build()

        self.snapCollectionViewModel = SnapCollectionViewModelBuilder()
            .set(books: topSection)
            .set(dependencies: dependencies)
            .build()
    }
}
