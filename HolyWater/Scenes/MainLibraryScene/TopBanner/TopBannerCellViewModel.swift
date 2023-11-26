//
//  TopBannerCellViewModel.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterServices
import RxCocoa
import RxSwift

final class TopBannerCellViewModel {

    private(set) var topBooks: [BookResponse.TopBannerSlideBook] = []

    private let subjectReloadData = PublishSubject<Void>()

    var outReloadData: Driver<Void> {
        subjectReloadData.asDriver(onErrorJustReturn: ())
    }

    private(set) var dependencies: Dependencies

    init(
        topBooks: [BookResponse.TopBannerSlideBook],
        dependencies: Dependencies) {
        self.topBooks = topBooks
        self.dependencies = dependencies
        self.reloadData()
    }

    private func reloadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.subjectReloadData.onNext(())
        }
    }
}
