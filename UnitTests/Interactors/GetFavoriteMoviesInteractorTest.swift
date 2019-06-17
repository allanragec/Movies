//
//  GetFavoriteMoviesInteractorTest.swift
//  MoviesTests
//
//  Created by Allan Melo on 16/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

@testable import Movies

import XCTest

class GetFavoriteMoviesInteractorTest: XCTestCase {
    override func setUp() {
        Settings.clearSession()

        generateSession(withAccount: true)
    }

    func testGetFavoriteMoviesInteractor() {
        guard let userAccount = Settings.userAccount else {
            XCTAssertNotNil(Settings.userAccount)

            return
        }

        let interactor = GetFavoriteMoviesInteractor(account: userAccount)
        let result = interactor.execute().result()

        XCTAssertNotNil(result)
        XCTAssertFalse(result!.results.isEmpty)
    }
}
