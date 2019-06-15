//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Allan Melo on 14/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit

class MovieDetailsViewController: ModularViewController<MovieDetailsViewModel> {

    @IBOutlet weak var tableView: UITableView?

    let movie: Movie

    lazy var viewModel = {
        return MovieDetailsViewModel(self)
    }()

    public init(movie: Movie) {
        self.movie = movie

        super.init(nibName: MovieDetailsViewController.className, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad()
    }

    override func getTableView() -> UITableView? {
        return tableView
    }

    override func getViewModel() -> MovieDetailsViewModel {
        return viewModel
    }
}
