//
//  GetUpcomingMoviesTest.swift
//  Movies
//
//  Created by Allan Melo on 14/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

@testable import Movies

import XCTest

class GetUpcomingMoviesTest: XCTestCase {

    func testGetUpcomingMoviesInteractor() {
        let interactor = GetUpcomingMoviesInteractor()
        let result = interactor.execute().result()

        XCTAssertNotNil(result)
        XCTAssertFalse(result!.results.isEmpty)
        XCTAssertEqual(result!.page, 1)
    }

    func testGetUpcomingMoviesInteractorPage2() {
        let interactor = GetUpcomingMoviesInteractor(page: 2)
        let result = interactor.execute().result()

        XCTAssertNotNil(result)
        XCTAssertFalse(result!.results.isEmpty)
        XCTAssertEqual(result!.page, 2)
    }
}

