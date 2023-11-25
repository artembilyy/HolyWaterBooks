//
//  BooksCollectionTableViewCellViewModel.swift
//  HolyWater
//
//  Created by Артем Билый on 24.11.2023.
//

import HolyWaterServices
import RxCocoa
import RxSwift

// final class BooksCollectionTableViewCellViewModel {
//
//    private(set) var books: [BookResponse.Book] = []
//
//    private let subjectReloadData = PublishSubject<Void>()
//
//    var outReloadData: Driver<Void> {
//        subjectReloadData.asDriver(onErrorJustReturn: ())
//    }
//
////    private(set) var dependencies: Dependencies
//
//    init(books: [BookResponse.Book]) {
//        self.books = books
//        self.reloadData()
//    }
//
//    private func reloadData() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.subjectReloadData.onNext(())
//        }
//    }
// }
