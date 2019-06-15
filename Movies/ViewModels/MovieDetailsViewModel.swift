//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Allan Melo on 14/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import Foundation

class MovieDetailsViewModel {

    weak var viewController: MovieDetailsViewController?

    // MARK: - LifeCycle

    init(_ viewController: MovieDetailsViewController) {
        self.viewController = viewController
    }

    func viewDidLoad() {
         viewController?.removeBackTitle()
    }
}
