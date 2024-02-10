//
//  SceneDelegate.swift
//  HolyWater
//
//  Created by Артем Билый on 20.11.2023.
//

import Firebase
import RxRelay
import RxSwift
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private enum DisplayStatus {
        case readyForDisplay
        case unknown
    }

    private let readyForDisplay = BehaviorRelay<Bool>(value: false)
    private let progressBarFullyFilled = BehaviorRelay<Bool>(value: false)

    var window: UIWindow?

    var appCoordinator: MainAppCoordinator?

    private var splashPresenter: SplashPresenterDescription? = SplashPresenter()
    private let disposeBag = DisposeBag()

    // swiftlint:disable line_length
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // swiftlint:enable line_length
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        Task {
            let dependencies = await AppDependenciesAssembly().assembleDependencies()
            appCoordinator = MainAppCoordinator(window: window, dependencies: dependencies)
            appCoordinator?.start()
        }

        splashScreen(windowScene: windowScene)
    }

    private func splashScreen(windowScene: UIWindowScene) {
        let delay: Double = 2
        guard let window else { return }

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setReadyDisplayStatus),
            name: .hideSplashScreen,
            object: nil)

        splashPresenter?.inject(
            scene: windowScene,
            mainWindow: window)

        splashPresenter?.present(with: delay)

        Observable.combineLatest(
            readyForDisplay.asObservable(),
            progressBarFullyFilled.asObservable())
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] ready, progressBarFilled in
                if ready && progressBarFilled {
                    dismissSplashScreen()
                }
            })
            .disposed(by: disposeBag)

        Task {
            try await Task.sleep(seconds: delay + 0.3)
            await MainActor.run { [unowned self] in
                progressBarFullyFilled.accept(true)
            }
        }
    }

    @objc
    private func setReadyDisplayStatus() {
        readyForDisplay.accept(true)
    }

    private func dismissSplashScreen() {
        splashPresenter?.dismiss { [unowned self] in
            splashPresenter = nil
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
