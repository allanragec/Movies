//
//  SearchMoviesInteractor.swift
//  Movies
//
//  Created by Allan Melo on 16/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift

class SearchMoviesInteractor {
    let query: String
    let page: Int

    init(query: String, page: Int = 1) {
        self.query = query
        self.page = page
    }

    func execute() -> Observable<SearchMoviesResult> {
        return createObservable()
    }
}

extension SearchMoviesInteractor: LoaderCodableObservable {
    typealias T = SearchMoviesResult

    func getUrl() -> String {
        return "\(Settings.ENDPOINT)/3/search/movie?api_key=\(Settings.API_KEY)&language=en-US&query=\(query)&page=\(page)&include_adult=false"
    }
}

struct SearchMoviesResult: Codable {
    let results: [Movie]
    let page: Int
    let totalPages: Int
    let totalResults: Int
}

