//
//  SplashAnimatior.swift
//  Matched
//
//  Created by Артем Билый on 20.11.2023.
//
//

import HolyWaterUI

protocol SplashAnimatorDescription: AnyObject {
    func animateAppearance(delay: Double)
    func animateDisappearance(completion: @escaping () -> Void)
}

final class SplashAnimator: SplashAnimatorDescription {

    // MARK: - Properties
    private unowned let splashWindow: UIWindow
    private unowned let mainWindow: UIWindow

    private let splashViewController: SplashViewController

    private var timer: Timer?

    // MARK: - Initialization

    required init(
        splashWindow: UIWindow,
        mainWindow: UIWindow) {
        self.splashWindow = splashWindow

        guard let splashViewController = splashWindow.rootViewController as? SplashViewController else {
            fatalError("Splash window doesn't have splash root view controller!")
        }

        self.splashViewController = splashViewController
        self.mainWindow = mainWindow
    }

    // MARK: - Appearance

    func animateAppearance(delay: Double) {
        splashWindow.isHidden = false

        UIView.animate(withDuration: 0.3) {
            self.splashViewController.titleImageView.transform = CGAffineTransform(scaleX: 80 / 72, y: 80 / 72)
        }

        startProgressAnimation(progressBar: splashViewController.progressBarView, duration: delay)
    }

    // MARK: - Disappearance

    func animateDisappearance(completion: @escaping () -> Void) {
        splashWindow.isHidden = false
        completion()
    }
}

private extension SplashAnimator {
    func startProgressAnimation(progressBar: ProgressBarView, duration: TimeInterval) {
        let updateInterval: TimeInterval = 0.05

        let totalSteps = Int(duration / updateInterval)
        let progressChangePerStep = 1.0 / CGFloat(totalSteps)

        timer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { [weak self] timer in
            guard let self else {
                timer.invalidate()
                return
            }

            progressBar.progress += progressChangePerStep

            if progressBar.progress >= 1.0 {
                self.stopProgressAnimation()
            }
        }
    }

    func stopProgressAnimation() {
        timer?.invalidate()
        timer = nil
    }
}
