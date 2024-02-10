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
                    Task {
                        await self.save(bookResponse: result)
                        await self.load()
                        self.subjectDataFetched.onNext(())
                    }
                case .failure(let failure):
                    subjectErrorCatched.onNext(failure)
                }
                NotificationCenter.default.post(name: .hideSplashScreen, object: nil)
            }
    }

    func selected(data: [BookResponse.Book]) {
        subjectOpenDetails.onNext(
            .init(
                topSection: data,
                bottomSection: youWillLikeSection)
        )
    }

    private func save(bookResponse: BookResponse) async {
        let bookEntity = BooksEntity(booksResponse: bookResponse)
        await dependencies.realmServiceWorker.saveObject(object: bookEntity)
    }

    private func load() async {
        await dependencies.realmServiceWorker.loadObject { (books: BooksEntity?) in
            guard let realmBooks = books?.books,
                  let topBannerSlides = books?.topBannerSlides,
                  let youWillLikeSection = books?.youWillLikeSection
            else {
                return
            }
            var books = [BookResponse.Book]()
            realmBooks.forEach { book in
                let realmBook = BookResponse.Book(
                    id: book.id,
                    name: book.name,
                    author: book.author,
                    summary: book.summary,
                    genre: book.genre,
                    coverURL: URL(string: book.coverURL),
                    views: book.views,
                    likes: book.likes,
                    quotes: book.quotes)
                books.append(realmBook)
                self.genres = Array(self.books.keys).sorted()
                self.books = Dictionary(grouping: books) { $0.genre ?? "" }
            }

            topBannerSlides.forEach { slide in
                let realmTopBannerSlide = BookResponse.TopBannerSlideBook(
                    id: slide.id,
                    bookID: slide.bookID,
                    cover: slide.cover)
                self.topBannerBooks.append(realmTopBannerSlide)
            }

            self.youWillLikeSection = books.filter {
                if let bookID = $0.id {
                    return youWillLikeSection.contains(bookID)
                }
                return false
            }
        }
    }
}
