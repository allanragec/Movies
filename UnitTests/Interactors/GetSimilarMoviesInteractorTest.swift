//
//  GetSimilarMoviesInteractorTest.swift
//  Movies
//
//  Created by Allan Melo on 16/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

@testable import Movies

import XCTest

class GetSimilarMoviesInteractorTest: XCTestCase {
    func testGetSimilarMoviesInteractor() {
        let interactor = GetSimilarMoviesInteractor(movieId: 9738)
        let result = interactor.execute().result()

        XCTAssertNotNil(result)
        XCTAssertFalse(result!.results.isEmpty)
    }
}
