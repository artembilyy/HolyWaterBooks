//
//  LibraryViewModel.swift
//  HolyWater
//
//  Created by Артем Билый on 21.11.2023.
//

import HolyWaterServices
import RxCocoa
import RxRelay
import RxSwift
import UIKit

protocol LibraryViewModelInteractive {
    var inputs: LibraryViewModelInputs { get }
    var outputs: LibraryViewModelOutputs { get }
}

typealias LibraryViewModelInterface =
    LibraryViewModelInputs &
    LibraryViewModelInteractive &
    LibraryViewModelOutputs

final class LibraryViewModel: LibraryViewModelInterface {

    typealias BookGenre = String
    typealias GroupedBooks = [BookGenre: [BookResponse.Book]]

    var dependencies: Dependencies!

    struct DetailsData {
        let topSection: [BookResponse.Book]
        let bottomSection: [BookResponse.Book]
    }

    private(set) var topBannerBooks: [BookResponse.TopBannerSlideBook] = [] {
        didSet {
            if topBannerBooks.count > 1,
               let firstBook = topBannerBooks.first,
               let lastBook = topBannerBooks.last {
                topBannerBooks.append(firstBook)
                topBannerBooks.insert(lastBook, at: 0)
            }
        }
    }
    private(set) var books: GroupedBooks = [:]
    private(set) var genres: [BookGenre] = []
    private var youWillLikeSection: [BookResponse.Book] = []

    private let subjectOpenDetails = PublishSubject<DetailsData>()
    private let subjectDataFetched = PublishSubject<Void>()
    private let subjectErrorCatched = PublishSubject<NetworkError>()

    var outOpenDetails: Driver<DetailsData> {
        subjectOpenDetails
            .asDriver(onErrorDriveWith: .empty())
    }

    var reloadData: Driver<Void> {
        subjectDataFetched
            .asDriver(onErrorJustReturn: ())
    }

    var outputError: Driver<NetworkError> {
        subjectErrorCatched
            .asDriver(onErrorDriveWith: .never())
    }

    var animeScroll: Driver<Void> {
        subjectDataFetched
            .asDriver(onErrorJustReturn: ())
    }

    var inputs: LibraryViewModelInputs {
        return self
    }

    var outputs: LibraryViewModelOutputs {
        return self
    }

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func fetch() {
        dependencies
            .firebaseRemoteConfigWorker
            .fetchData { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let result):

                    if let topBannerSlides = result.topBannerSlides {
                        self.topBannerBooks = topBannerSlides
                    }

                    guard let books = result.books else { return }
                    self.books = Dictionary(grouping: books) { $0.genre ?? "" }
                    self.genres = Array(self.books.keys).sorted()

                    if let youWillLikeIDs = result.youWillLikeSection {
                        self.youWillLikeSection = books.filter {
                            if let bookID = $0.id {
                                return youWillLikeIDs.contains(bookID)
                            }
                            return false
                        }
                    }
                    subjectDataFetched.onNext(())
                case .failure(let failure):
                    subjectErrorCatched.onNext(failure)
                }
            }
    }

    func selected(data: [BookResponse.Book]) {
        subjectOpenDetails.onNext(
            .init(
                topSection: data,
                bottomSection: youWillLikeSection)
        )
    }
}
