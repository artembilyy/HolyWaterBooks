//
//  LibraryViewModel.swift
//  HolyWater
//
//  Created by Артем Билый on 21.11.2023.
//

import HolyWaterServices
import RxRelay
import RxSwift

protocol LibraryViewModelInputs {
    func fetch()
    func sendCrashReport(event: CrashAnalytics.CrashEvent, source: String?)
}

protocol LibraryViewModelOutputs {
    var books: BehaviorRelay<[String: [Book]]> { get }
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

    public var books: BehaviorRelay<GroupedBooks> = BehaviorRelay(value: [:])

    var inputs: LibraryViewModelInputs {
        return self
    }

    var outputs: LibraryViewModelOutputs {
        return self
    }

    private let disposeBag = DisposeBag()

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

    func sendCrashReport(event: CrashAnalytics.CrashEvent, source: String?) {
        dependencies
            .crashAnalyticReporter
            .sendCrashReport(
                crash: event, from: source)
    }
}
