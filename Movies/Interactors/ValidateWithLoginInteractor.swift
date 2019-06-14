//
//  ValidateWithLoginInteractor.swift
//  MoviesTests
//
//  Created by Allan Melo on 14/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift

class ValidateWithLoginInteractor {

    let requestToken: String
    let username: String
    let password: String

    init(requestToken: String, username: String, password: String) {
        self.requestToken = requestToken
        self.username = username
        self.password = password
    }

    func execute() -> Observable<RequestTokenResult> {
        return createObservable()
    }
}

extension ValidateWithLoginInteractor: LoaderCodableObservable {
    typealias T = RequestTokenResult

    func getUrl() -> String {
        return "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=\(Settings.API_KEY)"
    }

    func getBody() -> Data? {
        return ["username": username,
                "password": password,
                "request_token": requestToken]
            .asData()
    }

    func getHttpMethod() -> String {
        return "POST"
    }
}
