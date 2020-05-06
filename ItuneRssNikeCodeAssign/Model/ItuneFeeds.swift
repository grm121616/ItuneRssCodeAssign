//
//  ItuneFeeds.swift
//  ItuneRssNikeCodeAssign
//
//  Created by Ruoming Gao on 5/4/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import Foundation

struct ItuneFeeds: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let results: [Result]
    let title: String
}

struct Result: Codable {
    let artistName: String
    let name: String
    let artworkUrl100: URL
    let releaseDate: String
    let copyright: String
    let genres: [Genre]
    let artistUrl: String
}

struct Genre: Codable {
    let name: String
}
