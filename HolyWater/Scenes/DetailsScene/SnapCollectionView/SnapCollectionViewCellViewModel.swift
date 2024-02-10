//
//  SnapCollectionViewCellViewModel.swift
//  HolyWater
//
//  Created by Артем Билый on 26.11.2023.
//

import HolyWaterServices
import HolyWaterUI

final class SnapCollectionViewCellViewModel: AsyncOperation {

    typealias Dependencies =
        ImageLoadingWorkerContrainer

    let book: BookResponse.Book
    let dependencies: Dependencies

    init(book: BookResponse.Book, dependencies: Dependencies) {
        self.book = book
        self.dependencies = dependencies
    }

    @MainActor
    func loadImage(
        completion: @escaping (UIImage?) -> Void
    ) {
        guard let url = book.coverURL?.absoluteString else {
            completion(nil)
            return
        }
        performAsyncOperation { [weak self] in
            try await self?.dependencies
                .imageLoadingManagerWorker
                .getImage(from: url)
        } completion: { image in
            if let image {
                completion(image)
            }
        }
    }
}
