//
//  GetGenresInteractor.swift
//  Movies
//
//  Created by Allan Melo on 15/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift

class GetGenresInteractor {
    func execute() -> Observable<GenresResult> {
        return createObservable()
            .do(onNext: { Settings.genres = $0 })
    }
}

extension GetGenresInteractor: LoaderCodableObservable {
    typealias T = GenresResult

    func getUrl() -> String {
        return "\(Settings.ENDPOINT)/3/genre/movie/list?api_key=\(Settings.API_KEY)&language=en-US"
    }
}

struct GenresResult: Codable {
    let genres: [Genre]
    struct Genre: Codable {
        let id: Int
        let name: String
    }

    func getTitles(ids: [Int]) -> [String] {
        return genres
            .filter({ ids.contains($0.id) })
            .map({ $0.name })
    }
}
