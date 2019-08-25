//
//  MasterViewController.swift
//  RedditReader
//
//  Created by Matias Ginart on 25/08/2019.
//  Copyright © 2019 Matias Ginart. All rights reserved.
//

import UIKit

class TopEntryListViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var entries: [RedditEntry]?
    var topEntriesService: RedditTopEntriesService? = nil
    var redditEntryManager: RedditEntryManager = RedditEntryManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
//        navigationItem.leftBarButtonItem = editButtonItem
//
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
//        navigationItem.rightBarButtonItem = addButton
//        if let split = splitViewController {
//            let controllers = split.viewControllers
//            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
//        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)

        showLoadingView()

        // In viewWillAppear so we can ge the latest entries
        topEntriesService = RedditTopEntriesService()
        topEntriesService?.makeRequest(callback: { (response, error) in
            DispatchQueue.main.async {
                self.hideLoadingView()
            }

            guard let topEntriesData = response?.data else {
                self.presentError(message: "There was an error loading the messages")
                return
            }
            self.entries = topEntriesData.children

            DispatchQueue.main.async {
                self.reloadData()
            }
        })
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        topEntriesService?.invalidate()
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let object = objects[indexPath.row] as! NSDate
//                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
//                controller.detailItem = object
//                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
//                controller.navigationItem.leftItemsSupplementBackButton = true
//            }
        }
    }
}

// MARK: - Table View
extension TopEntryListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "topEntryCell", for: indexPath) as? TopEntryTableViewCell,
            let redditEntry = entries?[indexPath.row]
        else {
            return UITableViewCell()
        }

        cell.authorNameLabel.text = redditEntry.authorName
        cell.postCreatedLabel.text = redditEntry.created?.timeAgoSinceDate()
        cell.readView.isRead = redditEntryManager.redditEntryWasRead(redditEntry)
        cell.thumbnailImageView.downloaded(from: redditEntry.thumbnail)
        cell.titleEntryLabel.text = redditEntry.title
        cell.numberOfCommentsLabel.text = numberOfCommentsText(forNumberOfComments: redditEntry.numberOfComments)
        cell.dismissClossure = { [weak self] (_) in
            // Do something with the array data and update the tableView
        }

        return cell
    }
}

extension TopEntryListViewController {
    // Just in case we need to do something else tomorrow (happened more than once in my lifetime)
    private func reloadData() {
        tableView.reloadData()
    }

    // Should go in a viewModel or some helper
    private func numberOfCommentsText(forNumberOfComments numberOfComments: Int?) -> String {
        guard
            let numberOfCommentsUnwrapped = numberOfComments,
            numberOfCommentsUnwrapped != 0
        else {
            return "No comments" // Like a politian when asked a difficult question
        }

        // Or use internationalization (i remember that now you can use single and non single strings)
        if numberOfCommentsUnwrapped > 1 {
            return String(numberOfCommentsUnwrapped) + " comments"
        } else {
            return "1 comment"
        }
    }
}

// MARK: Traits
extension TopEntryListViewController: ErrorPresenter {}
extension TopEntryListViewController: Loadeable {}

