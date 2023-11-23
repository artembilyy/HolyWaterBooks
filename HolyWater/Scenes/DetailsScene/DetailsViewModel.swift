//
//  DetailsViewModel.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import HolyWaterServices
// swiftlint:disable line_length
final class DetailsViewModel {

    let mainStackViewModel: MainStackViewModel

    init() {
        self.mainStackViewModel = MainStackViewModelBuilder()
            .set(readersCount: "22.2k")
            .set(likesCount: "10.4k")
            .set(quotesCount: "32.5k ")
            .set(genre: "Hot")
            .set(description: "According to researchers at Duke University, habits account for about 40 percent of our behaviors on any given day. Your life today is essentially the sum of your habits. How in shape or out of shape you are? A result of your habits. How happy or unhappy you are? A result of your habits. How successful or unsuccessful you are? A result of your habits.")
            .set(books: DetailsViewModel.data)
            .build()
    }
}

extension DetailsViewModel {

    static let data: [BookResponse.Book] = [
        BookResponse.Book(
            id: 1,
            name: "The Art of Programming",
            author: "John Coder",
            summary: "A masterpiece that explores the beauty of code.",
            genre: "Programming",
            coverURL: URL(string: "https://example.com/art_of_programming.jpg"),
            views: "1000",
            likes: "500",
            quotes: "Code is poetry."),
        BookResponse.Book(
            id: 2,
            name: "Mystery in the Dark",
            author: "Jane Sleuth",
            summary: "An intriguing mystery that keeps you on the edge of your seat.",
            genre: "Mystery",
            coverURL: URL(string: "https://example.com/mystery_in_the_dark.jpg"),
            views: "800",
            likes: "300",
            quotes: "Every clue leads to another question."),
        BookResponse.Book(
            id: 3,
            name: "Sci-Fi Odyssey",
            author: "Alex Explorer",
            summary: "A journey through the cosmos and beyond.",
            genre: "Science Fiction",
            coverURL: URL(string: "https://example.com/sci_fi_odyssey.jpg"),
            views: "1200",
            likes: "700",
            quotes: "In space, no one can hear you scream.")
    ]
}
// swiftlint:enable line_length
