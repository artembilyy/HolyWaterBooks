//
//  SplashPresenter.swift
//  Matched
//
//  Created by Артем Билый on 20.11.2023.
//
//

import UIKit

protocol SplashPresenterDescription: AnyObject {
    func inject(scene: UIWindowScene, mainWindow: UIWindow)
    func present(with delay: Double)
    func dismiss(completion: @escaping () -> Void)
}

final class SplashPresenter: SplashPresenterDescription {

    // MARK: - Properties

    private var scene: UIWindowScene!
    private var mainWindow: UIWindow!

    func inject(scene: UIWindowScene, mainWindow: UIWindow) {
        self.scene = scene
        self.mainWindow = mainWindow
    }

    private lazy var animator: SplashAnimatorDescription = SplashAnimator(
        splashWindow: splashWindow,
        mainWindow: mainWindow)

    private lazy var splashWindow: UIWindow = {
        let splashViewController = SplashViewController()
        let splashWindow = splashWindow(windowLevel: .normal + 1, rootViewController: splashViewController)

        return splashWindow
    }()

    // MARK: - Helpers

    private func splashWindow(
        windowLevel: UIWindow.Level,
        rootViewController: SplashViewController?) -> UIWindow {

        let splashWindow = UIWindow(windowScene: scene)

        splashWindow.windowLevel = windowLevel
        splashWindow.rootViewController = rootViewController

        return splashWindow
    }

    // MARK: - SplashPresenterDescription

    func present(with delay: Double) {
        animator.animateAppearance(delay: delay)
    }

    func dismiss(completion: @escaping () -> Void) {
        animator.animateDisappearance(completion: completion)
    }
}
