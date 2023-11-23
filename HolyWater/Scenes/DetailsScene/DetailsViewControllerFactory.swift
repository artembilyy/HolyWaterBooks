//
//  DetailsViewControllerFactory.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import Foundation

enum DetailsScreenFactory {

    static func instantiate(
        viewModel: DetailsViewModel
    ) -> DetailsViewController {

        let viewController = DetailsViewController()
        viewController.inject(viewModel: viewModel)
        return viewController
    }
}
