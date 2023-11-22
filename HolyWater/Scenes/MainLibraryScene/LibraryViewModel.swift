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
    var topBannerBooks: BehaviorRelay<[Book]> { get }
    var books: BehaviorRelay<[String: [Book]]> { get }
    var outOpenDetails: Driver<Book?> { get }
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
    typealias GroupedBooks = [BookGenre: [Book]]

    private var dependencies: Dependencies!

    private(set) var topBannerBooks: BehaviorRelay<[Book]> = BehaviorRelay(value: [])
    private(set) var books: BehaviorRelay<GroupedBooks> = BehaviorRelay(value: [:])

    private let subjectOpenDetails = PublishSubject<Book>()

    var outOpenDetails: Driver<Book?> {
        return subjectOpenDetails
            .map { book in
                return book
            }
            .asDriver(onErrorJustReturn: nil)
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
                    self.books.accept(Dictionary(grouping: result.books) { $0.genre })
                case .failure(let failure):
                    print(failure)
                }
            }
    }

    func selected() {
        guard let book = books.value["Fantasy"]?[0] else { return }
        subjectOpenDetails.onNext(book)
    }

    func sendCrashReport(event: CrashAnalytics.CrashEvent, source: String?) {
        dependencies
            .crashAnalyticReporter
            .sendCrashReport(
                crash: event, from: source)
    }
}
