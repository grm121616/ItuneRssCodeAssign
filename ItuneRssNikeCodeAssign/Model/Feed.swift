//
//  Feed.swift
//  ItuneRssNikeCodeAssign
//
//  Created by Ruoming Gao on 5/6/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import Foundation

struct Feed: Codable {
    let results: [Result]
    let title: String
}
