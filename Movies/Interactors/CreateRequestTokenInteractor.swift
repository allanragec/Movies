//
//  CreateRequestTokenInteractor.swift
//  Movies
//
//  Created by Allan Melo on 13/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift

class CreateRequestTokenInteractor {
    func execute() -> Observable<RequestTokenResult> {
        return createObservable()
            .do(onNext: { Settings.requestToken = $0 })
    }
}

extension CreateRequestTokenInteractor: LoaderCodableObservable {
    typealias T = RequestTokenResult

    func getUrl() -> String {
        return "https://api.themoviedb.org/3/authentication/token/new?api_key=\(Settings.API_KEY)"
    }
}

struct RequestTokenResult: Codable {
    let success: Bool
    let expiresAt: String
    let requestToken: String
}
