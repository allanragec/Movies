//
//  CreateRequestTokenInteractorTest.swift
//  MoviesTests
//
//  Created by Allan Melo on 13/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

@testable import Movies

import XCTest

class CreateRequestTokenInteractorTest: XCTestCase {

    override func setUp() {
        super.setUp()

        Settings.clearSession()
    }

    func testCreateRequestTokenInteractor() {
        let interactor = CreateRequestTokenInteractor()
        let requestToken = interactor.execute().result()

        let storedRequestToken = Settings.requestToken

        XCTAssertNotNil(requestToken)
        XCTAssertNotNil(requestToken?.requestToken)

        XCTAssertEqual(requestToken?.requestToken, storedRequestToken?.requestToken)

        XCTAssertEqual(requestToken?.expiresAt, storedRequestToken?.expiresAt)
        
        XCTAssertEqual(requestToken?.success, storedRequestToken?.success)
    }
}

