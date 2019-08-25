//
//  RedditTopEntriesResponse.swift
//  RedditReader
//
//  Created by Matias Ginart on 25/08/2019.
//  Copyright © 2019 Matias Ginart. All rights reserved.
//

import Foundation

struct RedditTopEntriesResponse: Decodable {
    let data: RedditTopEntriesData

    enum CodingKeys: String, CodingKey {
        case data
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode(RedditTopEntriesData.self, forKey: .data)
    }
}
