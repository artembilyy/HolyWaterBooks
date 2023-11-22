//
//  HomeFlow.swift
//  HolyWater
//
//  Created by Артем Билый on 21.11.2023.
//

import UIKit

final class HomeFlow {

    private let window: UIWindow?
    private let dependencies = AppDependenciesAssembly.assembleDependencies()

    required init(window: UIWindow?) {
        self.window = window
    }

    func start() {
        startDefaultHomeFlow()
    }

    private func startDefaultHomeFlow() {

        let viewModel: LibraryViewModelInteractive = LibraryViewModel(dependencies: dependencies)
        let libraryViewController = MainLibraryFactory.instantiate(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: libraryViewController)

        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}
