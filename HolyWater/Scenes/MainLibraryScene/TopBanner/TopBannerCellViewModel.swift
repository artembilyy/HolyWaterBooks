//
//  TopBannerCellViewModel.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterServices
import RxCocoa
import RxSwift
import UIKit

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
    }

    func reloadData() {
        self.subjectReloadData.onNext(())
    }

    @MainActor
    func loadImage(
        for indexPath: Int,
        completion: @escaping (UIImage?) -> Void) {
        guard let url = topBooks[indexPath].cover else { return }
        Task {
            do {
                let image = try await dependencies
                    .imageLoadingManagerWorker
                    .getImage(from: url)
                completion(image)
            } catch {
                completion(nil)
            }
        }
    }
}
