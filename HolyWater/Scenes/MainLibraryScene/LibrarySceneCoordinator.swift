//
//  LibrarySceneCoordinator.swift
//  HolyWater
//
//  Created by Artem Bilyi on 09.02.2024.
//

import RxSwift
import UIKit

final class LibrarySceneCoordinator: Coordinator {

    typealias Dependencies = LibraryViewModel.Dependencies

    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    private var navigationController: UINavigationController?

    private let dependencies: Dependencies
    private let disposeBag = DisposeBag()

    init(
        navigationController: UINavigationController?,
        dependencies: Dependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {

        let viewModel: LibraryViewModelInteractive = LibraryViewModel(
            dependencies: dependencies)
        let libraryViewController = MainLibraryFactory.instantiate(
            viewModel: viewModel,
            dependencies: dependencies)

        viewModel
            .outputs
            .outOpenDetails
            .drive(onNext: { [unowned self] books in
                showDetailsScreen(with: books)
            })
            .disposed(by: disposeBag)

        navigationController?.setViewControllers([libraryViewController], animated: true)
    }

    private func showDetailsScreen(with data: LibraryViewModel.DetailsData) {
        let viewController = DetailsScreenFactory.instantiate(
            viewModel: DetailsViewModel(
                topSection: data.topSection,
                bottomSection: data.bottomSection,
                dependencies: dependencies)
        )
        navigationController?.pushViewController(viewController, animated: true)
    }
}
