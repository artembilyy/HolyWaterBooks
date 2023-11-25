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
    var configurator: LibraryViewModelConfigurator { get }
}

typealias LibraryViewModelInterface =
    LibraryViewModelConfigurator &
    LibraryViewModelInputs &
    LibraryViewModelInteractive &
    LibraryViewModelOutputs

final class LibraryViewModel: LibraryViewModelInterface {

    typealias BookGenre = String
    typealias GroupedBooks = [BookGenre: [BookResponse.Book]]

    var dependencies: Dependencies!

    private(set) var topBannerBooks: [BookResponse.TopBannerSlideBook] = [] {
        didSet {
            if topBannerBooks.count > 1, let firstBook = topBannerBooks.first, let lastBook = topBannerBooks.last {
                topBannerBooks.append(firstBook)
                topBannerBooks.insert(lastBook, at: 0)
            }
        }
    }
    private(set) var books: GroupedBooks = [:]
    private(set) var youWillLikeSection: [Int] = []

    private let subjectOpenDetails = PublishSubject<BookResponse.Book>()
    private let subjectDataFetched = PublishSubject<Void>()
    private let subjectErrorCatched = PublishSubject<NetworkError>()

    var outOpenDetails: Driver<BookResponse.Book?> {
        subjectOpenDetails
            .map { book in
                return book
            }
            .asDriver(onErrorJustReturn: nil)
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

    var configurator: LibraryViewModelConfigurator {
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

                    if let books = result.books {
                        self.books = Dictionary(grouping: books) { $0.genre ?? "" }
                    }

                    if let youWillLikeSection = result.youWillLikeSection {
                        self.youWillLikeSection = youWillLikeSection
                    }

                    subjectDataFetched.onNext(())
                case .failure(let failure):
                    subjectErrorCatched.onNext(failure)
                }
            }
    }

    func selected() {
        guard let book = books["Fantasy"]?[0] else { return }
        subjectOpenDetails.onNext(book)
    }
}
