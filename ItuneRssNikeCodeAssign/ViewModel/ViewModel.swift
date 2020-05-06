//
//  ViewModel.swift
//  ItuneRssNikeCodeAssign
//
//  Created by Ruoming Gao on 5/4/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import Foundation

class ViewModel: ViewModelProtocol {
    
    private var results: [Result] = [] {
        didSet {
            updateCallBack?()
        }
    }
    
    private var updateCallBack: (()->Void)?
    
    private var apiRequestLoader: APIRequestLoader
    
    init(apiRequestLoader: APIRequestLoader? = nil) {
        if let apiRequestLoader = apiRequestLoader {
            self.apiRequestLoader = apiRequestLoader
        } else {
            let ituneRssNetworkConfig: APIRequestConfigure = ItunesRssNetworkConfig()
            let apiRequestLoader = APIRequestLoader(apiRequest: ituneRssNetworkConfig)
            self.apiRequestLoader = apiRequestLoader
        }
    }
    
    func registerUpdate(updateCallBack: @escaping ()->Void) {
        self.updateCallBack = updateCallBack
    }
    
    func loadData() {
        apiRequestLoader.loadRequest { (music: ItuneFeeds?, error) in
            guard let music = music else { return }
            self.results = music.feed.results
        }
    }
    
    func getCount() -> Int {
        return results.count
    }
    
    func getViewModelResult(index: Int) -> ViewModelresult {
        return ViewModelresult(ituneResult: results[index])
    }
}

protocol ViewModelProtocol {
    func loadData()
    func getCount() -> Int
    func getViewModelResult(index: Int) -> ViewModelresult
    func registerUpdate(updateCallBack: @escaping ()->Void)
}

