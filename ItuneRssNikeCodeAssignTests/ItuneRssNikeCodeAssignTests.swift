//
//  ItuneRssNikeCodeAssignTests.swift
//  ItuneRssNikeCodeAssignTests
//
//  Created by Ruoming Gao on 5/4/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import XCTest
@testable import ItuneRssNikeCodeAssign

class ItuneRssNikeCodeAssignTests: XCTestCase {
    
    var sut: ViewModel!
    
    var validUrl = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json"
    
    var ituneRssData: Data {
        let url = Bundle(for: ItuneRssNikeCodeAssignTests.self).url(forResource: "ItuneRssJson", withExtension: "txt")!
        let data = try! Data(contentsOf: url)
        return data
    }

    override func setUp() {
        let apiRequestConfigure = NetworkRequestConfigure(url: validUrl, cachePolicy: nil, timeoutInterval: nil, header: nil, httpBody: nil, httpMethod: nil)
        let session = URLMockSession(data: ituneRssData, error: nil)
        let apiRequestLoader = APIRequestLoader(apiRequest: apiRequestConfigure, urlSession: session)
        sut = ViewModel(apiRequestLoader: apiRequestLoader)
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testLoadData() {
        sut.loadData()
        let result = sut.getViewModelResult(index: 0)
        XCTAssertEqual(sut.getCount(), 45)
        XCTAssertEqual(result.getAlbumName(), "Gaslighter")
        XCTAssertEqual(result.getName(), "Dixie Chicks")
        XCTAssertEqual(result.getArtistUrl(), "https://music.apple.com/us/artist/dixie-chicks/635633?app=music")
        XCTAssertEqual(result.getReleaseDate(), "2020-05-01")
        XCTAssertEqual(result.getCopyRights(), "℗ 2020 Columbia Records, a Division of Sony Music Entertainment")
        XCTAssertEqual(result.getGenre(), "Country")
        let session = URLMockSession(data: ituneRssData, error: nil)
        result.getImage(session: session, completion: { (data) in
            XCTAssertNotNil(data)
        })
    }
}
