//
//  GetWatchlistInteractor.swift
//  Movies
//
//  Created by Allan Melo on 17/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift

class GetWatchlistMoviesInteractor {
    let account: AccountResult
    let page: Int

    init(account: AccountResult, page: Int = 1) {
        self.account = account
        self.page = page
    }

    func execute() -> Observable<MoviesResult> {
        return createObservable()
    }
}

extension GetWatchlistMoviesInteractor: LoaderCodableObservable {
    typealias T = MoviesResult

    func getUrl() -> String {
        let sessionId = Settings.sessionId ?? ""

        return "\(Settings.ENDPOINT)/3/account/\(account.id)/watchlist/movies?api_key=\(Settings.API_KEY)&session_id=\(sessionId)&language=en-US&sort_by=created_at.asc&page=\(page)"
    }
}

class WatchlistMoviesLoader: LoaderMovies {
    func getObservable(page: Int) -> Observable<MoviesResult> {
        guard let accountResult = Settings.userAccount else {
            return Observable.empty()
        }

        return GetWatchlistMoviesInteractor(account: accountResult, page: page)
            .execute()
    }
}


