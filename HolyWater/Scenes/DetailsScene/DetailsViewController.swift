//
//  DetailsViewController.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import HolyWaterServices
import HolyWaterUI

final class DetailsViewController: UIViewController {

    private var viewModel: DetailsViewModel! {
        didSet {
            mainStackView.viewModel = viewModel.mainStackViewModel
        }
    }

    private let snapCollectionView: SnapCollectionView = .init()
    private let mainStackView: MainStackView = .init()
    private let contentView: UIView = .init()
    private let scrollView: UIScrollView = .init()

    func inject(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }

    private func setupUI() {
        view.backgroundColor = .white

        contentView.translatesAutoresizingMaskIntoConstraints = false

        setupScrollView()

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews([snapCollectionView, mainStackView])
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
    }

    private func setupNavigationBar() {
        let leftBarButtonItem = UIBarButtonItem(
            customView: UIImageView(image: UIImage(named: "bi_arrow-down"))
        )
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
}

extension DetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let navigationController else { return }
        let topInset = UIApplication.shared.statusBarHeight + navigationController.navigationBar.frame.height
        if scrollView.contentOffset.y <= -topInset {
            scrollView.contentOffset.y = -topInset
        }
    }
}

private extension DetailsViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: -(navigationController?.navigationBar.frame.height ?? 0)),
            scrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(
                equalTo: scrollView.topAnchor,
                constant: -UIApplication.shared.statusBarHeight),
            contentView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(
                equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor),

            snapCollectionView.topAnchor.constraint(
                equalTo: contentView.topAnchor),
            snapCollectionView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor),
            snapCollectionView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor),

            mainStackView.topAnchor.constraint(
                equalTo: snapCollectionView.bottomAnchor,
                constant: -22),
            mainStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            mainStackView.bottomAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.bottomAnchor,
                constant: -84)
        ])
    }
}
