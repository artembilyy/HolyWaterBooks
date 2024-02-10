//
//  RealmBookEntity.swift
//  HolyWaterServices
//
//  Created by Artem Bilyi on 09.02.2024.

import HolyWaterServices
import Realm
import RealmSwift

final class BooksEntity: Object {

    @Persisted(primaryKey: true) var id = RealmPrimaryKey.bookResponse.rawValue
    @Persisted var books: List<BookEntity>
    @Persisted var topBannerSlides: List<TopBannerSlideBook>
    @Persisted var youWillLikeSection: List<Int>

    convenience init(booksResponse: BookResponse) {
        self.init()
        guard let books = booksResponse.books,
              let topBannerSlides = booksResponse.topBannerSlides,
              let youWillLikeSection = booksResponse.youWillLikeSection
        else {
            return
        }
        let realmBooks = List<BookEntity>()
        books.forEach { book in
            let realmBook = BookEntity()
            realmBook.id = book.id ?? 0
            realmBook.author = book.author ?? ""
            realmBook.name = book.name ?? ""
            realmBook.genre = book.genre ?? ""
            realmBook.coverURL = book.coverURL?.absoluteString ?? ""
            realmBook.likes = book.likes ?? ""
            realmBook.quotes = book.quotes ?? ""
            realmBook.summary = book.summary ?? ""
            realmBook.views = book.views ?? ""
            realmBooks.append(realmBook)
        }

        let realmTopBannerSlides = List<TopBannerSlideBook>()

        topBannerSlides.forEach { book in
            let realmTopBannerSlide = TopBannerSlideBook()
            realmTopBannerSlide.id = book.id ?? 0
            realmTopBannerSlide.cover = book.cover ?? ""
            realmTopBannerSlide.bookID = book.bookID ?? 0
            realmTopBannerSlides.append(realmTopBannerSlide)
        }

        let realmYouWillLikeSection = List<Int>()

        youWillLikeSection.forEach { bookID in
            realmYouWillLikeSection.append(bookID)
        }

        self.books = realmBooks
        self.topBannerSlides = realmTopBannerSlides
        self.youWillLikeSection = realmYouWillLikeSection
    }
}

final class BookEntity: Object {

    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var author: String
    @Persisted var summary: String
    @Persisted var genre: String
    @Persisted var coverURL: String
    @Persisted var views: String
    @Persisted var likes: String
    @Persisted var quotes: String
}

final class TopBannerSlideBook: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var bookID: Int
    @Persisted var cover: String
}
