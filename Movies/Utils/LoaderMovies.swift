//
//  LoaderMovies.swift
//  Movies
//
//  Created by Allan Melo on 17/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift

protocol LoaderMovies {
    func getObservable(page: Int) -> Observable<MoviesResult>
}
