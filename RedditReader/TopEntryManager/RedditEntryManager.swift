//
//  TopEntryManager.swift
//  RedditReader
//
//  Created by Matias Ginart on 25/08/2019.
//  Copyright © 2019 Matias Ginart. All rights reserved.
//

import Foundation

class RedditEntryManager {
    private struct Constants {
        static let entriesKey = "entriesKey"
    }

    private var entriesSaved: [String]

    init() {
        entriesSaved = UserDefaults.standard.stringArray(forKey: Constants.entriesKey) ?? []
    }

    func redditEntryWasRead(_ entry: RedditEntry) -> Bool {
        return entriesSaved.contains(entry.id)
    }

    func redditEntryIsBeingRead(_ entry: RedditEntry) {
        entriesSaved.append(entry.id)
    }

    deinit {
        UserDefaults.standard.set(entriesSaved, forKey: Constants.entriesKey)
        UserDefaults.standard.synchronize()
    }
}
