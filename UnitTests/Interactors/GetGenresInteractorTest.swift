//
//  GetGenresInteractorTest.swift
//  MoviesTests
//
//  Created by Allan Melo on 15/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

@testable import Movies

import XCTest

class GetGenresInteractorTest: XCTestCase {
    override func setUp() {
        Settings.genres = nil
    }
    
    func testGetGenresInteractor() {
        let interactor = GetGenresInteractor()
        let result = interactor.execute().result()

        XCTAssertNotNil(result)
        XCTAssertFalse(result!.genres.isEmpty)
        XCTAssertEqual(result?.genres.count, Settings.genres?.genres.count)
    }
}


