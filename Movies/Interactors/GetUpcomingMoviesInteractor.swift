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

    func execute() -> Observable<UpcomingMoviesResult> {
        return createObservable()
            .map({ resultServer in
                let upcomingMovies = resultServer
                    .results
                    .filter({ $0.releaseDateAsDate().isTodayOrFuture() })
                    .sorted(by: { first, second in
                        return first.releaseDateAsDate().timeIntervalSince1970 <
                            second.releaseDateAsDate().timeIntervalSince1970
                    })

                return UpcomingMoviesResult(results: upcomingMovies,
                                            page: resultServer.page,
                                            totalPages: resultServer.totalPages)
            })
    }
}

extension GetUpcomingMoviesInteractor: LoaderCodableObservable {
    typealias T = UpcomingMoviesResult

    func getUrl() -> String {
        return "https://api.themoviedb.org/3/movie/upcoming?api_key=\(Settings.API_KEY)&page=\(page)"
    }
}

struct UpcomingMoviesResult: Codable {
    let results: [Movie]
    let page: Int
    let totalPages: Int
}

struct Movie: Codable {
    let id: Int64
    let title: String
    let voteCount: Int64
    let popularity: Double
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let genreIds: [Int]
    let overview: String
    let originalLanguage: String
    let voteAverage: Float

    func releaseDateAsDate() -> Date {
        let formatter = DateFormatter.dayFormatter

        return formatter.date(from: releaseDate) ?? Date.minimumDate()
    }
}
