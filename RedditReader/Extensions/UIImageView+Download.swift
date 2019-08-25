//
//  UIImageView+Download.swift
//  RedditReader
//
//  Created by Matias Ginart on 25/08/2019. <-- OMG! I just stole this from someone else and added my name. I hope the FBI don't see this, i am too young to be in jail!
//  Copyright © 2019 Matias Ginart. All rights reserved.
//

import Foundation
import UIKit

// This needs a cache... if alamofire was added i could do it with that, else use NSCache (or some other tool). Not today (if this was not an exercise i would use some of this tools
// But again... this was from stackoverflow (except from some minor changes), only 5 hours and i am not going to code this
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String?, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard
            let urlString = link,
            let url = URL(string: urlString)
        else {
            // This was not here in stackoverflow... BAD CODER VERY BAD
            image = nil
            return
        }
        downloaded(from: url, contentMode: mode)
    }
}
