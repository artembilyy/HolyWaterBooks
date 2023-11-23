//
//  AlertDisplayable.swift
//  HolyWaterError
//
//  Created by Артем Билый on 23.11.2023.
//

import UIKit

public protocol AlertDisplayable {

    typealias CompletionAction = () -> Void

    func displayAlert(error: NetworkError, completion: CompletionAction?)
}

extension AlertDisplayable where Self: UIViewController {

    public func displayAlert(
        error: NetworkError,
        completion: CompletionAction? = nil) {

        let alertController: UIAlertController = .init(
            title: "Error",
            message: error.description,
            preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
            completion?()
        }

        alertController.addAction(okAction)

        present(alertController, animated: true, completion: completion)
    }
}
