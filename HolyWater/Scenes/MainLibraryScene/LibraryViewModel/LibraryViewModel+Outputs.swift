//
//  LibraryViewModel+Outputs.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterServices
import RxCocoa

protocol LibraryViewModelOutputs {
    var topBannerBooks: [BookResponse.TopBannerSlideBook] { get }
    var books: [String: [BookResponse.Book]] { get }
    var youWillLikeSection: [Int] { get }

    var outOpenDetails: Driver<BookResponse.Book?> { get }
    var reloadData: Driver<Void> { get }
    var outputError: Driver<NetworkError> { get }
}
