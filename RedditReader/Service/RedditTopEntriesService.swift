//
//  RedditTopEntriesService.swift
//  RedditReader
//
//  Created by Matias Ginart on 25/08/2019.
//  Copyright © 2019 Matias Ginart. All rights reserved.
//

import Foundation

typealias RedditTopEntriesServiceCallback = (RedditTopEntriesResponse?, Error?) -> ()

struct RedditTopEntriesService {
    private var task: URLSessionDataTask?

    mutating func makeRequest(callback: @escaping RedditTopEntriesServiceCallback, numberOfEntries: Int = 50) {
        guard var urlComponents = URLComponents(string: "https://www.reddit.com/top.json") else {
            callback(nil, nil)
            return
        }
        urlComponents.queryItems = [URLQueryItem(name: "limit", value: String(numberOfEntries))]

        guard let url = urlComponents.url else {
            callback(nil, nil)
            return
        }

        let session = URLSession.shared
        task = session.dataTask(with: url) { (data, response, error) in
            guard let networingData = data else {
                callback(nil, nil)
                return
            }

            guard let entriesResponse =  try? JSONDecoder().decode(RedditTopEntriesResponse.self, from: networingData) else {
                callback(nil, nil)
                return
            }

            callback(entriesResponse, nil)
        }
        task?.resume()
    }

    mutating func invalidate() {
        task?.cancel()
        task = nil
    }
}
