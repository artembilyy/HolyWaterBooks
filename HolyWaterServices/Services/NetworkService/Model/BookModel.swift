//
//  BookModel.swift
//  HolyWater
//
//  Created by Артем Билый on 21.11.2023.
//

import Foundation

public struct Books: Decodable {
    public let books: [Book]
}

public struct Book: Decodable {
    public let id: Int
    public let name: String
    public let author: String
    public let summary: String
    public let genre: String
    public let coverURL: URL
    public let views: String
    public let likes: String
    public let quotes: String

    public enum CodingKeys: String, CodingKey {
        case id, name, author, summary, genre, views, likes, quotes
        case coverURL = "cover_url"
    }
}
