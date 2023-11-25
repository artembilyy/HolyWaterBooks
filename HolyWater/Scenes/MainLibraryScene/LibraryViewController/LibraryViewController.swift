//
//  LibraryViewController.swift
//  HolyWater
//
//  Created by Артем Билый on 20.11.2023.
//

import HolyWaterServices
import HolyWaterUI
import RxSwift

extension LibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let section = MainSection(rawValue: indexPath.section)

        if case .topBooks = section {
            let width = tableView.frame.width - 32
            return width * 0.47 + 40
        } else {
            return 200
        }
    }
}

extension LibraryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let topBookCell = tableView.dequeueReusableCell(withIdentifier: TopBooksCollectionTableViewCell.identifier) as? TopBooksCollectionTableViewCell,
            let bookCell = tableView.dequeueReusableCell(withIdentifier: BooksCollectionTableViewCell.identifier) as? BooksCollectionTableViewCell
        else {
            return UITableViewCell()
        }

        let section = MainSection(rawValue: indexPath.section)

        if case .topBooks = section {
            if viewModel.outputs.topBannerBooks.isEmpty.not {
                topBookCell.viewModel = .init(
                    topBooks: viewModel.outputs.topBannerBooks,
                    dependencies: dependencies)
            }
            return topBookCell
        } else {
            return bookCell
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1 + viewModel.outputs.books.keys.count
    }
}

final class LibraryViewController: UIViewController, AlertDisplayable {

    enum MainSection: Int, CaseIterable {
        case topBooks
        case books
    }

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

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = view.bounds

        tableView.register(
            TopBooksCollectionTableViewCell.self,
            forCellReuseIdentifier: TopBooksCollectionTableViewCell.identifier)
        tableView.register(BooksCollectionTableViewCell.self, forCellReuseIdentifier: BooksCollectionTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

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
