//
//  RedditTopEntriesData.swift
//  RedditReader
//
//  Created by Matias Ginart on 25/08/2019.
//  Copyright © 2019 Matias Ginart. All rights reserved.
//

import Foundation

struct RedditTopEntriesData: Decodable {
    let children: [RedditEntry]
    let after: String?
    
    enum CodingKeys: String, CodingKey {
        case children
        case after
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        children = try container.decode([RedditEntry].self, forKey: .children)
        after = try? container.decode(String.self, forKey: .after)
    }
}
