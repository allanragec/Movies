//
//  Movie.swift
//  Movies
//
//  Created by Allan Melo on 16/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let id: Int64
    let title: String
    let originalTitle: String
    let voteCount: Int64
    let popularity: Double
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let genreIds: [Int]
    let overview: String
    let originalLanguage: String
    let voteAverage: Float

    func releaseDateAsDate() -> Date {
        let formatter = DateFormatter.dayFormatter

        return formatter.date(from: releaseDate) ?? Date.minimumDate()
    }
}
