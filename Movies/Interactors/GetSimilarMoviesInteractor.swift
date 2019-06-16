//
//  GetSimilarMoviesInteractor.swift
//  Movies
//
//  Created by Allan Melo on 16/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift

class GetSimilarMoviesInteractor {
    let movieId: Int64
    let page: Int

    init(movieId: Int64, page: Int = 1) {
        self.movieId = movieId
        self.page = page
    }

    func execute() -> Observable<SimilarMoviesResult> {
        return createObservable()
    }
}

extension GetSimilarMoviesInteractor: LoaderCodableObservable {
    typealias T = SimilarMoviesResult

    func getUrl() -> String {
        return "https://api.themoviedb.org/3/movie/\(movieId)/similar?api_key=\(Settings.API_KEY)&language=en-US&page=\(page)"
    }
}

struct SimilarMoviesResult: Codable {
    let results: [Movie]
    let page: Int
    let totalPages: Int
    let totalResults: Int
}
