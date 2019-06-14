//
//  CreateSessionInteractorTest.swift
//  MoviesTests
//
//  Created by Allan Melo on 14/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

@testable import Movies

import XCTest

class CreateSessionInteractorTest: XCTestCase {

    override func setUp() {
        super.setUp()

        Settings.clearSession()

        let createTokenInteractor = CreateRequestTokenInteractor()
        let requestToken = createTokenInteractor.execute().result()?.requestToken ?? ""

        let validateTokenInteractor = ValidateWithLoginInteractor(requestToken: requestToken, username: "unittestsmoviedb", password: "12345")

        _ = validateTokenInteractor.execute().result()
    }

    func testCreateSessionInteractor() {
        let interactor = CreateSessionInteractor()

        let result = interactor.execute().result()

        XCTAssertNotNil(result)
        XCTAssertTrue(result?.success ?? false)
        XCTAssertFalse(result?.sessionId.isEmpty ?? true)
    }
}
