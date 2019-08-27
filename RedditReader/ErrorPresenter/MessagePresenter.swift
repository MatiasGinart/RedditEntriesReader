//
//  ErrorPresenter.swift
//  RedditReader
//
//  Created by Matias Ginart on 25/08/2019.
//  Copyright © 2019 Matias Ginart. All rights reserved.
//

import Foundation
import UIKit

protocol MessagePresenter {
    func presentMessage(title: String?, message: String)
}

extension MessagePresenter where Self: UIViewController {
    func presentMessage(title: String? = nil, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
