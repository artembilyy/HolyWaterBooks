//
//  BookModel.swift
//  HolyWater
//
//  Created by Артем Билый on 21.11.2023.
//

import Foundation

public struct BookResponse: Decodable, Hashable {

    public let books: [Book]?
    public let topBannerSlides: [TopBannerSlideBook]?
    public let youWillLikeSection: [Int]?

    public enum CodingKeys: String, CodingKey {
        case books
        case topBannerSlides = "top_banner_slides"
        case youWillLikeSection = "you_will_like_section"
    }

    public struct Book: Decodable, Hashable {
        public let id: Int?
        public let name: String?
        public let author: String?
        public let summary: String?
        public let genre: String?
        public let coverURL: URL?
        public let views: String?
        public let likes: String?
        public let quotes: String?

        public enum CodingKeys: String, CodingKey {
            case id, name, author, summary, genre, views, likes, quotes
            case coverURL = "cover_url"
        }

        public init(
            id: Int? = nil,
            name: String? = nil,
            author: String? = nil,
            summary: String? = nil,
            genre: String? = nil,
            coverURL: URL? = nil,
            views: String? = nil,
            likes: String? = nil,
            quotes: String? = nil) {
            self.id = id
            self.name = name
            self.author = author
            self.summary = summary
            self.genre = genre
            self.coverURL = coverURL
            self.views = views
            self.likes = likes
            self.quotes = quotes
        }
    }

    public struct TopBannerSlideBook: Decodable, Hashable {
        public let id: Int?
        public let bookID: Int?
        public let cover: String?

        public enum CodingKeys: String, CodingKey {
            case id
            case bookID = "book_id"
            case cover
        }

        public init(
            id: Int? = nil,
            bookID: Int? = nil,
            cover: String? = nil) {
            self.id = id
            self.bookID = bookID
            self.cover = cover
        }
    }
}
