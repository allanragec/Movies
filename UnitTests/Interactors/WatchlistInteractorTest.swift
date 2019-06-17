//
//  WatchlistInteractorTest.swift
//  MoviesTests
//
//  Created by Allan Melo on 17/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

@testable import Movies

import XCTest

class WatchlistInteractorTest: XCTestCase {
    override func setUp() {
        Settings.clearSession()

        generateSession(withAccount: true)
    }

    func testGetMovieAccountStatesInteractor() {
        let movieId: Int64 = 501633
        let interactor = WatchlistInteractor(watchlist: true, movieId: movieId)
        let result = interactor.execute().result()

        XCTAssertNotNil(result)
    }
}
