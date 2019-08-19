//
//  SearchMoviesInteractorTest.swift
//  MoviesTests
//
//  Created by Allan Melo on 16/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

@testable import Movies

import XCTest

class SearchMoviesInteractorTest: XCTestCase {
    func testSearchMoviesInteractor() {
        let interactor = SearchMoviesInteractor(query: "Avengers")
        let result = interactor.execute().result()

        XCTAssertNotNil(result)
        XCTAssertFalse(result!.results.isEmpty)
    }
}


