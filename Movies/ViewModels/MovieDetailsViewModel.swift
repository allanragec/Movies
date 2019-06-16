//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Allan Melo on 14/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailsViewModel {

    weak var viewController: MovieDetailsViewController?

    // MARK: - LifeCycle

    init(_ viewController: MovieDetailsViewController) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        setupHeaderView()
    }

    private func setupHeaderView() {
        guard let viewController = viewController else { return }
        let movie = viewController.movie

        viewController.movieTitleLabel?.text = movie.title
        viewController.releaseDateLabel?.text = "Release \(movie.releaseDate)"

        let genres = Settings.genres?.getTitles(ids: movie.genreIds) ?? []
        viewController.tokenView?.tokens = genres

        if let backdropPath = movie.backdropPath {
            viewController.backdropImageView?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(backdropPath)"))
        }

        let hasImage = movie.posterPath != nil
        showPosterImageView(hasImage)

        if let posterPath = movie.posterPath {
            viewController.posterImageView?.sd_setImage(
                with: URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)"),
                completed: { [weak self] image, _, _, _ in
                    self?.showPosterImageView(image != nil)
                })
        }
    }

    private func showPosterImageView(_ show: Bool) {
        viewController?.posterWidthConstraint?.constant = show ? 110 : 0
    }
}

extension MovieDetailsViewModel: ModularViewModel {
    func refresh() {
        viewController?.refreshControl.endRefreshing()
    }

    func registerCellItems() {
        getTableView()?.register(cellController: DescriptionCellItem.self)
    }

    func getTableView() -> UITableView? {
        return viewController?.tableView
    }

    func getItems() -> [CellItemController] {
        guard let movie = viewController?.movie else { return [] }
        
        return [DescriptionCellItem(description: movie.overview)]
    }
}

extension MovieDetailsViewModel: CollapsibleHeaderView {
    func getHeaderView() -> UIView? {
        return viewController?.headerView
    }

    func getHeaderHeightConstraint() -> NSLayoutConstraint? {
        return viewController?.headerViewHeightConstraint
    }

    func getMaximumHeaderSize() -> CGFloat {
        let movie = viewController?.movie
        let dontHaveImages = movie?.posterPath == nil && movie?.backdropPath == nil

        return dontHaveImages ? getPinnedHeaderSize() : 240
    }

    func getPinnedHeaderSize() -> CGFloat {
        return 140
    }
}
