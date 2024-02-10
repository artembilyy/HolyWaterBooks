//
//  DetailsViewController.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import HolyWaterServices
import HolyWaterUI

final class DetailsViewController: UIViewController {

    var viewModel: DetailsViewModel? {
        didSet {
            guard let viewModel else { return }
            mainStackView.viewModel = viewModel.mainStackViewModel
            snapCollectionView.viewModel = viewModel.snapCollectionViewModel
        }
    }

    private let snapCollectionView = SnapCollectionView()
    private let mainStackView = MainStackView()
    private let contentView = UIView()
    private let scrollView = UIScrollView()

    func inject(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureNavigationItem()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }

    private func setupUI() {
        view.backgroundColor = .white
        snapCollectionView.delegate = self

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

    private func configureNavigationBar() {
        navigationController?
            .navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?
            .navigationBar.shadowImage = UIImage()
        navigationController?
            .navigationBar.barTintColor = UIColor.clear
        navigationController?
            .navigationBar.tintColor = .white
    }

    private func configureNavigationItem() {
        let backImage: UIImage? = .init(named: "bi_arrow-down")
        let backButton: UIBarButtonItem = .init(
            image: backImage,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton

    }

    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
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

extension DetailsViewController: SnapCollectionDelegate {
    func centeredCellIndexChanged(to index: Int) {
        guard let viewModel else { return }
        viewModel.mainBook = viewModel.topSection[index]
        mainStackView.viewModel = viewModel.mainStackViewModel
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
