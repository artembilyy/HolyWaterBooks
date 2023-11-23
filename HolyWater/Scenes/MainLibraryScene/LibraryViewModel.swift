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

protocol LibraryViewModelInputs {
    func fetch()
    func selected()
    func sendCrashReport(event: CrashAnalytics.CrashEvent, source: String?)
}

protocol LibraryViewModelOutputs {
    var topBannerBooks: [BookResponse.TopBannerSlideBook] { get }
    var books: [String: [BookResponse.Book]] { get }
    var youWillLikeSection: [Int] { get }

    var outOpenDetails: Driver<BookResponse.Book?> { get }
    var reloadData: Driver<Void> { get }
}

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

    private var dependencies: Dependencies!

    private(set) var topBannerBooks: [BookResponse.TopBannerSlideBook] = []
    private(set) var books: GroupedBooks = [:]
    private(set) var youWillLikeSection: [Int] = []

    private let subjectOpenDetails = PublishSubject<BookResponse.Book>()
    private let dataFetched = PublishSubject<Void>()

    var outOpenDetails: Driver<BookResponse.Book?> {
        subjectOpenDetails
            .map { book in
                return book
            }
            .asDriver(onErrorJustReturn: nil)
    }

    var reloadData: Driver<Void> {
        dataFetched
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

                    if let books = result.books {
                        self.books = Dictionary(grouping: books) { $0.genre ?? "" }
                    }

                    if let youWillLikeSection = result.youWillLikeSection {
                        self.youWillLikeSection = youWillLikeSection
                    }

                    dataFetched.onNext(())
                case .failure(let failure):
                    print(failure)
                }
            }
    }

    func selected() {
        guard let book = books["Fantasy"]?[0] else { return }
        subjectOpenDetails.onNext(book)
    }

    func sendCrashReport(event: CrashAnalytics.CrashEvent, source: String?) {
        dependencies
            .crashAnalyticReporter
            .sendCrashReport(
                crash: event, from: source)
    }
}
