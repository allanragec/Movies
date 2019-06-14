//
//  ValidateWithLoginInteractorTest.swift
//  MoviesTests
//
//  Created by Allan Melo on 14/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

@testable import Movies

import XCTest

class ValidateWithLoginInteractorTest: XCTestCase {

    var requestToken = ""

    override func setUp() {
        super.setUp()

        Settings.clearSession()

        let interactor = CreateRequestTokenInteractor()
        requestToken = interactor.execute().result()?.requestToken ?? ""
    }

    func testValidateWithLoginInteractor() {
        let interactor = ValidateWithLoginInteractor(requestToken: requestToken, username: "unittestsmoviedb", password: "12345")

        let validatedRequestToken = interactor.execute().result()

        XCTAssertNotNil(validatedRequestToken)
        XCTAssertNotNil(validatedRequestToken?.requestToken)
        XCTAssertEqual(validatedRequestToken?.requestToken, requestToken)
    }
}
