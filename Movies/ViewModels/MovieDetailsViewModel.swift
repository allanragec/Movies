//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Allan Melo on 14/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit

class MovieDetailsViewModel {

    weak var viewController: MovieDetailsViewController?

    // MARK: - LifeCycle

    init(_ viewController: MovieDetailsViewController) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        viewController?.title = viewController?.movie.title
        viewController?.removeBackTitle()
    }
}

extension MovieDetailsViewModel: ModularViewModel {
    func refresh() {
    }

    func registerCellItems() {
    }

    func getTableView() -> UITableView? {
        return viewController?.tableView
    }

    func getItems() -> [CellItemController] {
        return []
    }
}
