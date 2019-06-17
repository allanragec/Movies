//
//  GetFavoriteMoviesInteractor.swift
//  Movies
//
//  Created by Allan Melo on 16/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift

class GetFavoriteMoviesInteractor {
    let account: AccountResult
    let page: Int

    init(account: AccountResult, page: Int = 1) {
        self.account = account
        self.page = page
    }

    func execute() -> Observable<FavoriteMoviesResult> {
        return createObservable()
    }
}

extension GetFavoriteMoviesInteractor: LoaderCodableObservable {
    typealias T = FavoriteMoviesResult

    func getUrl() -> String {
        let sessionId = Settings.sessionId ?? ""

        return "\(Settings.ENDPOINT)/3/account/\(account.id)/favorite/movies?api_key=\(Settings.API_KEY)&session_id=\(sessionId)&language=en-US&sort_by=created_at.asc&page=\(page)"
    }
}

struct FavoriteMoviesResult: Codable {
    let results: [Movie]
    let page: Int
    let totalPages: Int
    let totalResults: Int
}
