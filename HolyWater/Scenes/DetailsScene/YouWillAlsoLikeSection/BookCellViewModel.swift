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
}
