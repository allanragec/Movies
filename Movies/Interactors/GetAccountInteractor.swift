//
//  GetAccountInteractor.swift
//  Movies
//
//  Created by Allan Melo on 14/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift

class GetAccountInteractor {
    func execute() -> Observable<AccountResult> {
        return createObservable()
            .do(onNext: { Settings.userAccount = $0 })
    }
}

extension GetAccountInteractor: LoaderCodableObservable {
    typealias T = AccountResult

    func getUrl() -> String {
        let sessionId = Settings.sessionId ?? ""

        return "\(Settings.ENDPOINT)/3/account?api_key=\(Settings.API_KEY)&session_id=\(sessionId)"
    }
}

struct AccountResult: Codable {
    let avatar: Avatar?
    let id: Int64
    let name: String
    let username: String

    struct Avatar: Codable {
        let gravatar: Gravatar?

        struct Gravatar: Codable {
            let hash: String?
        }
    }
}
