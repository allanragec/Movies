//
//  XCTestCase.swift
//  MoviesTests
//
//  Created by Allan Melo on 17/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

@testable import Movies

import XCTest

extension XCTestCase {
    func generateSession(withAccount: Bool = false) {
        let createTokenInteractor = CreateRequestTokenInteractor()
        let requestToken = createTokenInteractor.execute().result()?.requestToken ?? ""

        let validateTokenInteractor = ValidateWithLoginInteractor(
            requestToken: requestToken,
            username: "unittestsmoviedb",
            password: "12345")

        _ = validateTokenInteractor.execute().result()

        _ = CreateSessionInteractor().execute().result()

        if withAccount {
            _ = GetAccountInteractor().execute().result()
        }
    }
}
