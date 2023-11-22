//
//  HomeFlow.swift
//  HolyWater
//
//  Created by Артем Билый on 21.11.2023.
//

import RxSwift
import UIKit

final class HomeFlow {

    private let window: UIWindow?
    private let dependencies: AppDependenciesAssembly.DependenciesContainer
    private let disposeBag = DisposeBag()

    required init(
        window: UIWindow?,
        dependencies: AppDependenciesAssembly.DependenciesContainer) {
        self.window = window
        self.dependencies = dependencies
    }

    func start() {
        startDefaultHomeFlow()
    }

    private func startDefaultHomeFlow() {

        let viewModel: LibraryViewModelInteractive = LibraryViewModel(dependencies: dependencies)

        let libraryViewController = MainLibraryFactory.instantiate(viewModel: viewModel)

        viewModel
            .outputs
            .outOpenDetails
            .drive(onNext: { _ in
                let vc = UIViewController()
                vc.view.backgroundColor = .blue
                libraryViewController.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)

        let navigationController = UINavigationController(rootViewController: libraryViewController)

        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}
