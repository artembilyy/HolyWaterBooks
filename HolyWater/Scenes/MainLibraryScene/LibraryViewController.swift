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

    private var viewModel: LibraryViewModelInteractive!

    private let disposeBag = DisposeBag()

    func inject(viewModel: LibraryViewModelInteractive) {
        self.viewModel = viewModel
    }

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

        createButton()

        view.addSubview(button)

        viewModel.inputs.fetch()

        viewModel
            .outputs
            .books
            .skip(1)
            .subscribe(onNext: { _ in
                // Handle the updated books here
//                print("Updated books: \(groupBooks)")
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
