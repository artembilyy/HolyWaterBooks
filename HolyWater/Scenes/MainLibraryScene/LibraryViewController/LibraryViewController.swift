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
        if indexPath.section != 0 {
            return 200
        } else {
            let width = tableView.frame.width - 32
            return width * 0.47
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

        if indexPath.section == 0 {
            topBookCell.viewModel = .init(
                topBooks: viewModel.outputs.topBannerBooks,
                dependencies: dependencies)
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

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        } else {
            let sortedKeys = viewModel.outputs.books.keys.sorted(by: <)
            return sortedKeys[section - 1]
        }
    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        if section == 2 {
//            let viewModel = HeaderViewModelBuilder()
//                .set(title: "Test")
//                .set(textColor: ThemeColor.black.asUIColor())
//                .build()
//
//            let view = tableView.dequeueReusableHeaderFooterView(
//                withIdentifier: HeaderView.identifier) as! HeaderView
//            view.viewModel = viewModel
//
//            return view
//        }
//        else { return nil }
//    }
}

final class LibraryViewController: UIViewController, AlertDisplayable {

    let button = UIButton(type: .system)

    enum MainSection: Int, CaseIterable {
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
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
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
