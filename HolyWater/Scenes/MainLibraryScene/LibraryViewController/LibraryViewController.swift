//
//  LibraryViewController.swift
//  HolyWater
//
//  Created by Артем Билый on 20.11.2023.
//

import HolyWaterServices
import HolyWaterUI
import RxSwift

private enum Constants: String {
    case leftHeadItem = "Library"
}

final class LibraryViewController: UIViewController, AlertDisplayable {

    lazy var collectionView = configureCollectionView()

    // swiftlint:disable implicitly_unwrapped_optional
    private var viewModel: LibraryViewModelInteractive!
    private var dependencies: Dependencies!
    // swiftlint:enable implicitly_unwrapped_optional

    private let disposeBag = DisposeBag()

    func inject(
        viewModel: LibraryViewModelInteractive,
        dependencies: Dependencies) {
        self.viewModel = viewModel
        self.dependencies = dependencies
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        Task {
            await viewModel.inputs.fetch()
        }
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        viewModel
            .inputs
            .sendCrashReport(
                event: .memoryWarning,
                source: String(describing: self))
    }

    private func setupUI() {
        navigationItem.leftBarButtonItem = .init(customView: leftItem())
        view.backgroundColor = ThemeColor.chaosBlack.asUIColor()
        view.addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self

        registerCells()
    }

    private func registerCells() {
        collectionView.register(cellType: BookCell.self)
        collectionView.register(cellType: TopBannerCollectionView.self)
        collectionView.registerHeader(type: CollectionViewHeader.self)
    }

    private func bindViewModel() {
        viewModel
            .outputs
            .reloadData
            .drive(onNext: { [weak self] _ in
                guard let self else { return }
                self.collectionView.reloadData()
            })
            .disposed(by: disposeBag)

        viewModel
            .outputs
            .outputError
            .drive(onNext: { [weak self] error in
                guard let self else { return }
                self.displayAlert(error: error)
            })
            .disposed(by: disposeBag)
    }

    private func configureNavigationBar() {
        navigationController?
            .navigationBar
            .setBackgroundImage(ThemeColor.chaosBlack.asUIColor().image(), for: .default)
        navigationController?
            .navigationBar
            .shadowImage = ThemeColor.chaosBlack.asUIColor().image()
        navigationController?
            .navigationBar
            .barTintColor = .clear
        navigationController?
            .navigationBar
            .tintColor = .clear
    }

    private func leftItem() -> UILabel {
        let label = UILabel()
        label.text = Constants.leftHeadItem.rawValue
        label.textColor = ThemeColor.raspberryPink.asUIColor()
        label.font = NunitoSans.bold(20).font
        label.textAlignment = .left
        return label
    }
}

extension LibraryViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath) -> UICollectionReusableView {

        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }

        let header: CollectionViewHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind, for: indexPath)
        let selectedGenre = viewModel.outputs.genres[indexPath.section - 1]
        header.title = selectedGenre
        return header
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let topBookCell: TopBannerCollectionView = collectionView.dequeueReusableCell(for: indexPath)
        let bookCell: BookCell = collectionView.dequeueReusableCell(for: indexPath)

        if indexPath.section == 0 {
            topBookCell.viewModel = .init(topBooks: viewModel.outputs.topBannerBooks, dependencies: dependencies)
            return topBookCell
        } else {
            let genre = viewModel.outputs.genres[indexPath.section - 1]

            if let booksForGenre = viewModel.outputs.books[genre] {
                bookCell.viewModel = .init(
                    books: booksForGenre,
                    dependencies: dependencies)
                bookCell.viewModel?.textStyle.accept(.home)
                bookCell.configureCell(indexPath: indexPath)
                return bookCell
            }
        }
        return UICollectionViewCell()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let topBannerSection = viewModel.outputs.topBannerBooks.isEmpty.not ? 1 : 0
        return topBannerSection + viewModel.outputs.genres.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.outputs.topBannerBooks.isEmpty.not ? 1 : 0
        } else {
            let genre = viewModel.outputs.genres[section - 1]
            let data = viewModel.outputs.books[genre]
            return data?.count ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let selectedGenre = viewModel.outputs.genres[indexPath.section - 1]

        if var selectedData = viewModel.outputs.books[selectedGenre] {
            let selectedBook = selectedData[indexPath.item]

            selectedData.remove(at: indexPath.item)
            selectedData.insert(selectedBook, at: 0)

            viewModel.inputs.selected(data: selectedData)
        }
    }
}
