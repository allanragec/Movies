//
//  GetMovieAccountStatesInteractorTest.swift
//  MoviesTests
//
//  Created by Allan Melo on 16/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

@testable import Movies

import XCTest

class GetMovieAccountStatesInteractorTest: XCTestCase {
    override func setUp() {
        Settings.clearSession()

        let createTokenInteractor = CreateRequestTokenInteractor()
        let requestToken = createTokenInteractor.execute().result()?.requestToken ?? ""

        let validateTokenInteractor = ValidateWithLoginInteractor(
            requestToken: requestToken,
            username: "unittestsmoviedb",
            password: "12345")

        _ = validateTokenInteractor.execute().result()

        _ = CreateSessionInteractor().execute().result()
    }

    func testGetMovieAccountStatesInteractor() {
        let interactor = GetMovieAccountStatesInteractor(movieId: 299534)
        let result = interactor.execute().result()

        XCTAssertNotNil(result)
        XCTAssertTrue(result!.favorite)
    }
}
