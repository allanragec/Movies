//
//  GetMovieAccountStatesInteractor.swift
//  Movies
//
//  Created by Allan Melo on 16/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift

class GetMovieAccountStatesInteractor {
    let movieId: Int64

    init(movieId: Int64) {
        self.movieId = movieId
    }

    func execute() -> Observable<MovieAccountStatesResult> {
        return createObservable()
    }
}

extension GetMovieAccountStatesInteractor: LoaderCodableObservable {
    typealias T = MovieAccountStatesResult

    func getUrl() -> String {
        let sessionId = Settings.sessionId ?? ""

        return "\(Settings.ENDPOINT)/3/movie/\(movieId)/account_states?api_key=\(Settings.API_KEY)&session_id=\(sessionId)"
    }
}

struct MovieAccountStatesResult: Codable {
    let id: Int64
    let favorite: Bool
    let watchlist: Bool
    let rate: Rate?

    struct Rate: Codable {
        let value: Int
    }
}

