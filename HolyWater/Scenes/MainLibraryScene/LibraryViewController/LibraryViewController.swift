//
//  LibraryViewController.swift
//  HolyWater
//
//  Created by Артем Билый on 20.11.2023.
//

import HolyWaterServices
import RxSwift
import UIKit

extension LibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let section = MainSection(rawValue: indexPath.section)

        switch section {
        case .topBooks:
            let width = tableView.frame.width - 32
            return width * 0.47
        case .books:
            return 0
        default:
            return 0
        }
    }
}

extension LibraryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let section = MainSection(rawValue: section)
        switch section {
        case .topBooks:
            return viewModel.outputs.topBannerBooks.count
        case .books:
            return 1
        default:
            return 1
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let section = MainSection(rawValue: indexPath.section)
        switch section {
        case .topBooks:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier) as? CollectionViewTableViewCell else { return UITableViewCell() }

            let topBannerCellViewModel = viewModel
                .configurator
                .configureTopBannerCellViewModel(
                    items: viewModel.outputs.topBannerBooks)
            cell.viewModel = TableViewCellViewModel(topBannerCellViewModel: topBannerCellViewModel)
            return cell
        case .books:
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}

final class LibraryViewController: UIViewController, AlertDisplayable {

    let button = UIButton(type: .system)

    enum MainSection: Int, CaseIterable {
        case topBooks
        case books
    }

    // swiftlint:disable implicitly_unwrapped_optional
    var viewModel: LibraryViewModelInteractive!
    // swiftlint:enable implicitly_unwrapped_optional

    private let disposeBag = DisposeBag()

    func inject(viewModel: LibraryViewModelInteractive) {
        self.viewModel = viewModel
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = view.bounds
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
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
        setupUI()
        createButton()

        viewModel.inputs.fetch()

        bindViewModel()
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
        view.backgroundColor = .purple
        view.addSubview(tableView)
        view.addSubview(button)
    }

    private func bindViewModel() {
        viewModel
            .outputs
            .reloadData
            .drive(onNext: { [weak self] _ in
                guard let self else { return }
                self.tableView.reloadData()

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
}
