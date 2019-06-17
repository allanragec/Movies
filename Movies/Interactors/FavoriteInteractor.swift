//
//  FavoriteInteractor.swift
//  Movies
//
//  Created by Allan Melo on 17/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift

class FavoriteInteractor {
    let movieId: Int64
    let favorite: Bool

    init(favorite: Bool, movieId: Int64) {
        self.favorite = favorite
        self.movieId = movieId
    }

    func execute() -> Observable<UpdateFavoriteResult> {
        return createObservable()
    }
}

extension FavoriteInteractor: LoaderCodableObservable {
    typealias T = UpdateFavoriteResult

    func getBody() -> Data? {
        let dictionary = ["media_type" : "movie",
                          "media_id"   : movieId,
                          "favorite"   : favorite]
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

        return "\(Settings.ENDPOINT)/3/account/\(userAccount.id)/favorite?api_key=\(Settings.API_KEY)&session_id=\(sessionId)"
    }
}

struct UpdateFavoriteResult: Codable {
    let statusCode: Int
    let statusMessage: String
}
