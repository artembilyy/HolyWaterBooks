//
//  SceneDelegate.swift
//  HolyWater
//
//  Created by Артем Билый on 20.11.2023.
//

import Firebase
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var homeFlow: HomeFlow?
    private var splashPresenter: SplashPresenterDescription? = SplashPresenter()

    // swiftlint:disable line_length
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // swiftlint:enable line_length
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        homeFlow = HomeFlow(
            window: window,
            dependencies: AppDependenciesAssembly().assembleDependencies())
        homeFlow?.start()

        splashScreen(windowScene: windowScene)
    }

    private func splashScreen(windowScene: UIWindowScene) {
        let delay: Double = 2
        guard let mainWindow = self.window else { return }

        splashPresenter?.inject(
            scene: windowScene,
            mainWindow: mainWindow)

        splashPresenter?.present(with: delay)

        Task {
            try await Task.sleep(seconds: delay + 0.3)
            await MainActor.run { [unowned self] in
                self.splashPresenter?.dismiss { [unowned self] in
                    self.splashPresenter = nil
                }
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
