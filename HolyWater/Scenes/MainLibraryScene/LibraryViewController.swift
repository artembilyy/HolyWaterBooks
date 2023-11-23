//
//  LibraryViewController.swift
//  HolyWater
//
//  Created by Артем Билый on 20.11.2023.
//

import RxSwift
import UIKit

final class LibraryViewController: UIViewController {

    let button = UIButton(type: .system)

    enum MainSection: Int, CaseIterable {
        case topBooks
        case books
    }

    // swiftlint:disable implicitly_unwrapped_optional
    unowned var dataSource: DataSource!
    var viewModel: LibraryViewModelInteractive!
    // swiftlint:enable implicitly_unwrapped_optional

    private let disposeBag = DisposeBag()

    func inject(viewModel: LibraryViewModelInteractive) {
        self.viewModel = viewModel
    }

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .black
        collectionView.register(
            TopBannerCell.self,
            forCellWithReuseIdentifier: TopBannerCell.identrifed)
        collectionView.dataSource = dataSource
        return collectionView
    }()

    private func createButton() {
        button.setTitle("Next screen", for: .normal)
        button.setTitleColor(.white, for: .normal)
        let buttonWidth: CGFloat = 150
        let buttonHeight: CGFloat = 50
        button.frame = CGRect(x: view.center.x, y: view.center.y, width: buttonWidth, height: buttonHeight)
        button.addAction(
            .init(handler: { [unowned self] _ in
                self.viewModel.inputs.selected()
            }), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple

        setupDataSource()

        view.addSubview(collectionView)

        createButton()

        view.addSubview(button)

        viewModel.inputs.fetch()

        viewModel
            .outputs
            .reloadData
            .drive(onNext: { [weak self] _ in
                guard let self else { return }
                self.applySnapshot()
            })
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        viewModel
            .inputs
            .sendCrashReport(
                event: .memoryWarning,
                source: String(describing: self))
    }
}
