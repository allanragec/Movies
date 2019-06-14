//
//  CreateSessionInteractor.swift
//  Movies
//
//  Created by Allan Melo on 13/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift

class CreateSessionInteractor {
    func execute() -> Observable<RequestSessionResult> {
        return createObservable()
            .do(onNext: { Settings.sessionId = $0.sessionId })
    }
}

extension CreateSessionInteractor: LoaderCodableObservable {
    typealias T = RequestSessionResult

    func getUrl() -> String {
        let requestToken = Settings.requestToken?.requestToken ?? ""

        return "https://api.themoviedb.org/3/authentication/session/new?request_token=\(requestToken)&api_key=\(Settings.API_KEY)"
    }
}

struct RequestSessionResult: Codable {
    let success: Bool
    let sessionId: String
}

