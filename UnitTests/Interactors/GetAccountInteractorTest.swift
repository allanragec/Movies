//
//  GetAccountInteractorTest.swift
//  MoviesTests
//
//  Created by Allan Melo on 14/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

@testable import Movies

import XCTest

class GetAccountInteractorTest: XCTestCase {

    override func setUp() {
        super.setUp()

        Settings.clearSession()

        let createTokenInteractor = CreateRequestTokenInteractor()
        let requestToken = createTokenInteractor.execute().result()?.requestToken ?? ""

        let validateTokenInteractor = ValidateWithLoginInteractor(requestToken: requestToken, username: "unittestsmoviedb", password: "12345")

        _ = validateTokenInteractor.execute().result()

        let createSessionInteractor = CreateSessionInteractor()

        _ = createSessionInteractor.execute().result()
    }

    func testCreateSessionInteractor() {
        let interactor = GetAccountInteractor()

        let account = interactor.execute().result()

        XCTAssertNotNil(account)
        XCTAssertEqual(account?.username, "unittestsmoviedb")
        XCTAssertEqual(account?.avatar?.gravatar?.hash, "f344bdf0248d52c3d01f1df362d9a8f3")
        XCTAssertEqual(account?.id, 8498733)
    }
}
