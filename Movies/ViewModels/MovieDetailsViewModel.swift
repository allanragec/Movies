//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Allan Melo on 14/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit
import SDWebImage
import UICircularProgressRing
import RxSwift
import NSObject_Rx

class MovieDetailsViewModel {

    weak var viewController: MovieDetailsViewController?

    var similars: [Movie] = [] {
        didSet {
            viewController?.tableView?.reloadData()
        }
    }

    // MARK: - LifeCycle

    init(_ viewController: MovieDetailsViewController) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        setupHeaderView()
        similarSubscribe()
    }

    private func similarSubscribe() {
        guard let viewController = viewController else { return }
        let movie = viewController.movie

         let backgroundThread = ConcurrentDispatchQueueScheduler(qos: .background)

        GetSimilarMoviesInteractor(movieId: movie.id)
            .execute()
            .map { result in result.results }
            .subscribeOn(backgroundThread)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { movies in
                self.similars = movies
            }, onError: { error in
                self.verifyError(error)
            })
            .disposed(by: viewController.rx.disposeBag)
    }

    private func setupHeaderView() {
        guard let viewController = viewController else { return }
        let movie = viewController.movie

        viewController.movieTitleLabel?.text = movie.title
        viewController.releaseDateLabel?.text = movie.releaseDate.isEmpty ?
            "" : "Release \(movie.releaseDate)"

        let userScoreCircular = viewController.userScoreCircularProgress
        userScoreCircular?.valueFormatter = VoteAverageFormatter()
        userScoreCircular?.style = .ontop
        userScoreCircular?.font = UIFont.boldSystemFont(ofSize: 12)
        userScoreCircular?.value = CGFloat(movie.voteAverage)

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

    private func verifyError(_ error: Error) {
        print("error \(error)")
    }
}

extension MovieDetailsViewModel: ModularViewModel {
    func refresh() {
        viewController?.refreshControl.endRefreshing()
    }

    func registerCellItems() {
        getTableView()?.register(cellController: DescriptionCellItem.self)
        getTableView()?.register(cellController: SectionTitleCellItem.self)
        getTableView()?.register(cellController: MovieCellItem.self)
    }

    func getTableView() -> UITableView? {
        return viewController?.tableView
    }

    func getItems() -> [CellItemController] {
        guard let movie = viewController?.movie else { return [] }

        var items = [CellItemController]()

        if !movie.overview.isEmpty {
            items.append(DescriptionCellItem(description: movie.overview))
        }

        items = items + SimilarModuleController(movies: similars).cellItems()

        return items
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

        return dontHaveImages ? getPinnedHeaderSize() : 270
    }

    func getPinnedHeaderSize() -> CGFloat {
        return 140
    }
}
