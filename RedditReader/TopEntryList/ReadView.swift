//
//  ReadView.swift
//  RedditReader
//
//  Created by Matias Ginart on 25/08/2019.
//  Copyright © 2019 Matias Ginart. All rights reserved.
//

import UIKit

// ReadView has always the same color
// TODO: Find a way to disallow setting the background color
class ReadView: UIView {
    private struct Constants {
        static let readColor = UIColor(red: 46/255, green: 122/255, blue: 246/255, alpha: 1)
    }

    var isRead: Bool = false {
        didSet {
            isHidden = isRead
            layer.cornerRadius = frame.size.width/2
            layer.borderColor = Constants.readColor.cgColor
            setNeedsLayout()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Constants.readColor
        clipsToBounds = true
    }
}
