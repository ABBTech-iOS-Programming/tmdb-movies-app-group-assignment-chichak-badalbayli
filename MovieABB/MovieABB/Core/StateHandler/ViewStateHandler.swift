//
//  ViewStateHandler.swift
//  Posts
//
//  Created by Chichek on 28.12.25.
//

import Foundation
import UIKit

final class ViewStateHandler {
    
    private let loader = UIActivityIndicatorView(style: .large)
    
    func attach(to controller: UIViewController) {
        controller.view.addSubview(loader)
        loader.center = controller.view.center
        loader.hidesWhenStopped = true
    }
    
    func handle(
        _ state: ViewState,
        in controller: UIViewController,
        onSuccess: (() -> Void)? = nil
    ) {
        switch state {
        case .loading:
            loader.startAnimating()
            
        case .success:
            loader.stopAnimating()
            onSuccess?()
            
        case .error(let message):
            loader.stopAnimating()
            showAlert(on: controller, message: message)
        }
    }
    
    private func showAlert(on controller: UIViewController, message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        controller.present(alert, animated: true)
    }
}

