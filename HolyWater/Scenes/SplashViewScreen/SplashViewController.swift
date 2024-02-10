//
//  SplashViewController.swift
//  Matched
//
//  Created by Артем Билый on 20.11.2023.
//
//

import HolyWaterUI

final class SplashViewController: UIViewController {

    // MARK: - Properties
    private let style = Style.defaultStyle()

    lazy var titleImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = style.titleImage
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    lazy var subtitleImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = style.subtitleImage
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    let progressBarView: ProgressBarView = .init()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        setupBackground()
        view.addSubviews([titleImageView, subtitleImageView, progressBarView])
    }

    private func setupBackground() {
        let backgroundImage: UIImageView = {
            $0.contentMode = .scaleAspectFill
            $0.image = style.backgroundImage
            $0.frame = view.bounds
            return $0
        }(UIImageView())

        let heartsImage: UIImageView = {
            $0.contentMode = .scaleAspectFit
            $0.image = style.heartsImage
            $0.frame = view.frame
            return $0
        }(UIImageView())

        view.backgroundColor = ThemeColor.black.asUIColor()
        view.addSubviews([backgroundImage, heartsImage])
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                titleImageView.topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: style.titleImageViewTopPadding),
                titleImageView.centerXAnchor.constraint(
                    equalTo: view.centerXAnchor),
                subtitleImageView.topAnchor.constraint(
                    equalTo: titleImageView.bottomAnchor,
                    constant: style.subtitleImageViewTopPadding),
                subtitleImageView.centerXAnchor.constraint(
                    equalTo: titleImageView.centerXAnchor),

                progressBarView.topAnchor.constraint(
                    equalTo: subtitleImageView.bottomAnchor,
                    constant: style.progressBarViewTopPadding),
                progressBarView.centerXAnchor.constraint(
                    equalTo: view.centerXAnchor),
                progressBarView.widthAnchor.constraint(
                    equalToConstant: style.progressBarViewWidth),
                progressBarView.heightAnchor.constraint(
                    equalToConstant: style.progressBarViewHeight)
            ]
        )
    }
}
