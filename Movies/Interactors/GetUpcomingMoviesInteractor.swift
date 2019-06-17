//
//  GetUpcomingMoviesInteractor.swift
//  Movies
//
//  Created by Allan Melo on 14/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift

class GetUpcomingMoviesInteractor {
    let page: Int

    init(page: Int = 1) {
        self.page = page
    }

    func execute() -> Observable<MoviesResult> {
        return createObservable()
            .map({ resultServer in
                let upcomingMovies = resultServer
                    .results
                    .filter({ $0.releaseDateAsDate().isTodayOrFuture() })
                    .sorted(by: { first, second in
                        return first.releaseDateAsDate().timeIntervalSince1970 <
                            second.releaseDateAsDate().timeIntervalSince1970
                    })

                return MoviesResult(results: upcomingMovies,
                                            page: resultServer.page,
                                            totalPages: resultServer.totalPages,
                                            totalResults: resultServer.totalResults)
            })
    }
}

extension GetUpcomingMoviesInteractor: LoaderCodableObservable {
    typealias T = MoviesResult

    func getUrl() -> String {
        return "\(Settings.ENDPOINT)/3/movie/upcoming?api_key=\(Settings.API_KEY)&page=\(page)"
    }
}

class UpcomingMoviesLoader: LoaderMovies {
    func getObservable(page: Int) -> Observable<MoviesResult> {
        return GetUpcomingMoviesInteractor(page: page).execute()
    }
}
