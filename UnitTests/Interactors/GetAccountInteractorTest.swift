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

        generateSession()
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
