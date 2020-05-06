//
//  ResultViewModel.swift
//  ItuneRssNikeCodeAssign
//
//  Created by Ruoming Gao on 5/4/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import Foundation

struct ResultViewModel {
    private let ituneResult: Result
    
    init(ituneResult: Result) {
        self.ituneResult = ituneResult
    }
    
    func getName() -> String {
        return ituneResult.artistName
    }
    
    func getAlbumName() -> String {
        return ituneResult.name
    }
    
    func getReleaseDate() -> String {
        return ituneResult.releaseDate
    }
    
    func getCopyRights() -> String {
        return ituneResult.copyright
    }
    
    func getGenre() -> String? {
        return ituneResult.genres.first?.name
    }
    
    func getArtistUrl() -> String {
        return ituneResult.artistUrl
    }
    
    func getImage(session: Session = URLSession.shared ,completion: @escaping(Data?)->Void) {
        let url = ituneResult.artworkUrl100
        session.getData(with: url) { (data, _) in
            completion(data)
        }
    }
}
