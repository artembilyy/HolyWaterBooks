//
//  AppCoordinator.swift
//  HolyWater
//
//  Created by Artem Bilyi on 09.02.2024.
//

import RxSwift
import UIKit

final class MainAppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []

    private let window: UIWindow?
    private let dependencies: AppDependenciesAssembly.DependenciesContainer

    required init(
        window: UIWindow?,
        dependencies: AppDependenciesAssembly.DependenciesContainer) {
        self.window = window
        self.dependencies = dependencies
    }

    func start() {
        startMainFlow()
    }

    func startMainFlow() {
        let navigationController = UINavigationController()
        let libraryCoordinator = LibrarySceneCoordinator(
            navigationController: navigationController,
            dependencies: dependencies)

        addChildCoordinator(libraryCoordinator)
        libraryCoordinator.start()

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
