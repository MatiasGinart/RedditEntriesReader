//
//  Loadeable.swift
//  RedditReader
//
//  Created by Matias Ginart on 25/08/2019.
//  Copyright © 2019 Matias Ginart. All rights reserved.
//

import Foundation
import UIKit

protocol Loadeable {
    func showLoadingView()
    func hideLoadingView()
}

extension Loadeable where Self: UIViewController {
    func showLoadingView() {
        // Stolen from stackOverflow <-- Doesn't mean that i couldn't do it, just faster this way and code was good enough
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }

    func hideLoadingView() {
        dismiss(animated: false, completion: nil)

    }
}
