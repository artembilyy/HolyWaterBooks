//
//  BookCellViewModel.swift
//  HolyWater
//
//  Created by Артем Билый on 25.11.2023.
//

import HolyWaterServices
import HolyWaterUI
import RxRelay

final class BookCellViewModel {

    enum TextStyle {
        case home
        case details

        var color: UIColor {
            switch self {
            case .home:
                return ThemeColor.white.asUIColor(alpha: 0.7)
            case .details:
                return ThemeColor.jetBlack.asUIColor()
            }
        }
    }

    private(set) var books: [BookResponse.Book]
    private(set) var dependencies: Dependencies
    let textStyle: BehaviorRelay<TextStyle> = BehaviorRelay(value: .home)

    init(
        books: [BookResponse.Book],
        dependencies: Dependencies) {
        self.books = books
        self.dependencies = dependencies
    }

    @MainActor
    func loadImage(
        for book: BookResponse.Book,
        completion: @escaping (UIImage?) -> Void) {

        guard let url = book.coverURL?.absoluteString else {
            completion(nil)
            return
        }

        Task {
            do {
                let image = try await dependencies.imageLoadingManagerWorker.getImage(from: url)
                completion(image)
            } catch {
                completion(nil)
            }
        }
    }
}
