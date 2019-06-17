//
//  WatchlistInteractor.swift
//  Movies
//
//  Created by Allan Melo on 17/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift

class WatchlistInteractor {
    let movieId: Int64
    let watchlist: Bool

    init(watchlist: Bool, movieId: Int64) {
        self.watchlist = watchlist
        self.movieId = movieId
    }

    func execute() -> Observable<UpdateWatchlistResult> {
        return createObservable()
    }
}

extension WatchlistInteractor: LoaderCodableObservable {
    typealias T = UpdateWatchlistResult

    func getBody() -> Data? {
        let dictionary = ["media_type" : "movie",
                          "media_id"   : movieId,
                          "watchlist"   : watchlist]
            as [String : AnyObject]

        return dictionary
            .toData()
    }

    func getHttpMethod() -> String {
        return "POST"
    }

    func getUrl() -> String {
        guard let sessionId = Settings.sessionId,
            let userAccount = Settings.userAccount else { return "" }

        return "\(Settings.ENDPOINT)/3/account/\(userAccount.id)/watchlist?api_key=\(Settings.API_KEY)&session_id=\(sessionId)"
    }
}

struct UpdateWatchlistResult: Codable {
    let statusCode: Int
    let statusMessage: String
}
