//
//  SimilarModuleController.swift
//  Movies
//
//  Created by Allan Melo on 16/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

class SimilarModuleController: ModuleController {
    let movies: [Movie]

    init(movies: [Movie]) {
        self.movies = movies
    }

    func cellItems() -> [CellItemController] {
        var cellItems = [CellItemController]()

        if !movies.isEmpty {
            cellItems.append(SectionTitleCellItem(title: "Similars"))

            let moviesCellItems = movies
                .map { MovieCellItem(movie: $0) }

            cellItems = cellItems + moviesCellItems

            return cellItems
        }

        return []
    }
}
