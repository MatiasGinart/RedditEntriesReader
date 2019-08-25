//
//  DetailViewController.swift
//  RedditReader
//
//  Created by Matias Ginart on 25/08/2019.
//  Copyright © 2019 Matias Ginart. All rights reserved.
//

import UIKit

class RedditEntryDetailViewController: UIViewController {
    @IBOutlet var authorNameLabel: UILabel!
    @IBOutlet var entryImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!

    var redditEntry: RedditEntry? {
        didSet {
            if isViewLoaded {
                configureView()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView() {
        guard let redditEntry = redditEntry else { return }
        authorNameLabel.text = redditEntry.authorName
        entryImageView.downloaded(from: redditEntry.thumbnail)
        titleLabel.text = redditEntry.title
    }

    @IBAction func imageWasTapped() {
        guard
            let urlString = redditEntry?.image,
            let url = URL(string: urlString)
        else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
