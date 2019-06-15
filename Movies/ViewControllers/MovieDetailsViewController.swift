//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Allan Melo on 14/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    let movie: Movie

    lazy var viewModel = {
        return MovieDetailsViewModel(self)
    }()

    public init(movie: Movie) {
        self.movie = movie

        super.init(nibName: MovieDetailsViewController.className, bundle: nil)

        title = movie.title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad()
    }
}
