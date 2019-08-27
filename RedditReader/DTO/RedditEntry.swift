//
//  RedditEntry.swift
//  RedditReader
//
//  Created by Matias Ginart on 25/08/2019.
//  Copyright © 2019 Matias Ginart. All rights reserved.
//

import Foundation

struct RedditEntry: Decodable {
    let id: String
    let authorName: String
    let title: String
    let numberOfComments: Int?
    let created: Date?
    let thumbnail: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case data
    }

    enum DataCodingKeys: String, CodingKey {
        case id
        // TODO: Seems this is just an id... need to check the api in more detail (not in these 5 hours though)
//        case authorName = "author_fullname"
        case authorName = "subreddit"
        case title
        case numberOfComments = "num_comments"
        case created
        case thumbnail
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .data)

        id = try dataContainer.decode(String.self, forKey: .id)
        authorName = try dataContainer.decode(String.self, forKey: .authorName)
        title = try dataContainer.decode(String.self, forKey: .title)
        numberOfComments = try? dataContainer.decodeIfPresent(Int.self, forKey: .numberOfComments)
        thumbnail = try? dataContainer.decodeIfPresent(String.self, forKey: .thumbnail)
        image = try? dataContainer.decodeIfPresent(String.self, forKey: .url)
        
        // TODO: Remember how to decode with formatter if i have spare time
        if let createdTimestamp = try? dataContainer.decode(TimeInterval.self, forKey: .created) {
            created = Date(timeIntervalSince1970: createdTimestamp)
        } else {
            created = nil
        }
    }
}

extension RedditEntry: Equatable {
    static func == (lhs: RedditEntry, rhs: RedditEntry) -> Bool {
        return lhs.id == rhs.id
    }
}
