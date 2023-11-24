//
//  LibraryViewControllerFactory.swift
//  HolyWater
//
//  Created by Артем Билый on 21.11.2023.
//

enum MainLibraryFactory {

    static func instantiate(
        viewModel: LibraryViewModelInteractive,
        dependencies: LibraryViewController.Dependencies) -> LibraryViewController {

        let viewController = LibraryViewController()
        viewController.inject(viewModel: viewModel, dependencies: dependencies)
        return viewController
    }
}
