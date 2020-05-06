//
//  ItunesRssRequestConfig.swift
//  ItuneRssNikeCodeAssign
//
//  Created by Ruoming Gao on 5/5/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import Foundation

struct ItunesRssRequestConfig: APIRequestConfigure {
    var url: String = Constant.ituneUrl
    
    var cachePolicy: URLRequest.CachePolicy?
    
    var timeoutInterval: TimeInterval?
    
    var header: [String : String]?
    
    var httpBody: Data?
    
    var httpMethod: String?
}
