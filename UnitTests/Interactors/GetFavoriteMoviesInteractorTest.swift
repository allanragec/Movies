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

        let createTokenInteractor = CreateRequestTokenInteractor()
        let requestToken = createTokenInteractor.execute().result()?.requestToken ?? ""

        let validateTokenInteractor = ValidateWithLoginInteractor(requestToken: requestToken, username: "unittestsmoviedb", password: "12345")

        _ = validateTokenInteractor.execute().result()

        _ = CreateSessionInteractor().execute().result()

        _ = GetAccountInteractor().execute().result()
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
