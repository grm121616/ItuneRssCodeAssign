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
            let ituneRssRequestConfig: APIRequestConfigure = ItunesRssRequestConfig()
            let apiRequestLoader = APIRequestLoader(apiRequest: ituneRssRequestConfig)
            self.apiRequestLoader = apiRequestLoader
        }
    }
    
    func registerUpdate(updateCallBack: @escaping ()->Void) {
        self.updateCallBack = updateCallBack
    }
    
    func loadData() {
        apiRequestLoader.loadRequest { (music: ItunesFeeds?, error) in
            guard let music = music else { return }
            self.results = music.feed.results
        }
    }
    
    func getCount() -> Int {
        return results.count
    }
    
    func getViewModelResult(index: Int) -> ResultViewModel {
        return ResultViewModel(ituneResult: results[index])
    }
}

protocol ViewModelProtocol {
    func loadData()
    func getCount() -> Int
    func getViewModelResult(index: Int) -> ResultViewModel
    func registerUpdate(updateCallBack: @escaping ()->Void)
}

