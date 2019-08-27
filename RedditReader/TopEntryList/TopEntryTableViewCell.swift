//
//  TopEntryTableViewCell.swift
//  RedditReader
//
//  Created by Matias Ginart on 25/08/2019.
//  Copyright © 2019 Matias Ginart. All rights reserved.
//

import UIKit

typealias TopEntryDismissClossure = (TopEntryTableViewCell) -> ()

// Yes, it is not generic. It is made for a top entry.
// Haven't seen the rest of the DTOs in the apis, there may be some DTOs that can fulfill the same data, if it is, this should be made more generic, starting with all the names and later allowing flexibility with the read view and the dismiss action
class TopEntryTableViewCell: UITableViewCell {
    private struct Constants {
        static let selectedBackgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        static let unselectedBackgroundColor = UIColor.black
    }

    @IBOutlet var readView:  ReadView!
    @IBOutlet var authorNameLabel: UILabel!
    @IBOutlet var postCreatedLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var titleEntryLabel: UILabel!
    @IBOutlet var numberOfCommentsLabel: UILabel!

    var dismissClossure: TopEntryDismissClossure? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        changeBackgroundColor(to: Constants.unselectedBackgroundColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            changeBackgroundColor(to: Constants.selectedBackgroundColor)
        } else {
            changeBackgroundColor(to: Constants.unselectedBackgroundColor)
        }
    }

    private func changeBackgroundColor(to color: UIColor) {
        backgroundColor = color
        contentView.backgroundColor = color
    }

    @IBAction func dismissTapped() {
        dismissClossure?(self)
    }
}
