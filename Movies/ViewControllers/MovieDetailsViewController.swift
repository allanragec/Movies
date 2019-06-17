//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Allan Melo on 14/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit
import UICircularProgressRing

class MovieDetailsViewController: ModularViewController<MovieDetailsViewModel> {

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var headerView: UIView?
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint?
    @IBOutlet weak var backdropImageView: UIImageView?
    @IBOutlet weak var posterImageView: UIImageView?
    @IBOutlet weak var movieTitleLabel: UILabel?
    @IBOutlet weak var tokenView: TokensView?
    @IBOutlet weak var releaseDateLabel: UILabel?
    @IBOutlet weak var posterWidthConstraint: NSLayoutConstraint?
    @IBOutlet weak var userScoreCircularProgress: UICircularProgressRing?

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.viewWillAppear()
    }

    override func getTableView() -> UITableView? {
        return tableView
    }

    override func getViewModel() -> MovieDetailsViewModel {
        return viewModel
    }

    @IBAction func backButton() {
        navigationController?.popViewController(animated: true)
    }
}
