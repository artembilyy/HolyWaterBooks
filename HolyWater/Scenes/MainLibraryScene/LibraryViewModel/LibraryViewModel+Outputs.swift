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
    var genres: [String] { get }

    var outOpenDetails: Driver<LibraryViewModel.DetailsData> { get }
    var reloadData: Driver<Void> { get }
    var outputError: Driver<NetworkError> { get }
}
