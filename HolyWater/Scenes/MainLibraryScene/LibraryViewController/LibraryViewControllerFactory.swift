//
//  LibraryViewControllerFactory.swift
//  HolyWater
//
//  Created by Артем Билый on 21.11.2023.
//

enum MainLibraryFactory {

    static func instantiate(
        viewModel: LibraryViewModelInteractive
    ) -> LibraryViewController {

        let viewController = LibraryViewController()
        viewController.inject(viewModel: viewModel)
        return viewController
    }
}
