//
//  LibraryViewController.swift
//  HolyWater
//
//  Created by Артем Билый on 20.11.2023.
//

import RxSwift
import UIKit

final class LibraryViewController: UIViewController {

    private var viewModel: LibraryViewModelInteractive!

    private let disposeBag = DisposeBag()

    func inject(viewModel: LibraryViewModelInteractive) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple

        viewModel.inputs.fetch()

        viewModel
            .outputs
            .books
            .skip(1)
            .subscribe(onNext: { groupBooks in
                // Handle the updated books here
                print("Updated books: \(groupBooks)")
            })
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        viewModel
            .inputs
            .sendCrashReport(
                event: .memoryWarning,
                source: self.description)
    }
}
