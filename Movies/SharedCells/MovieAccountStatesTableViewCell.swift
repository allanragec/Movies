//
//  MovieAccountStatesTableViewCell.swift
//  Movies
//
//  Created by Allan Melo on 16/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit
import UICircularProgressRing
import RxSwift
import NSObject_Rx

typealias UpdateMovieAccountState = (MovieAccountStatesResult) -> Void

class MovieAccountStatesCellItem: CellItemController {
    let accountStates: MovieAccountStatesResult
    let didUpdateMovieAccountState: UpdateMovieAccountState

    init(accountStates: MovieAccountStatesResult, didUpdateMovieAccountState: @escaping UpdateMovieAccountState) {
        self.accountStates = accountStates
        self.didUpdateMovieAccountState = didUpdateMovieAccountState
    }

    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let identifier = type(of: self).getIdentifier()

        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MovieAccountStatesTableViewCell
        cell?.configure(accountStates: accountStates, didUpdateMovieAccountState: didUpdateMovieAccountState)

        return cell ?? UITableViewCell(frame: .zero)
    }

    static func getIdentifier() -> String {
        return "MovieAccountStatesTableViewCell"
    }

    func openCell() {}
}

class MovieAccountStatesTableViewCell: UITableViewCell {
    @IBOutlet weak var watchListButton: UIButton?
    @IBOutlet weak var favoriteButton: UIButton?
    @IBOutlet weak var userRateCircularView: UICircularProgressRing?
    @IBOutlet weak var favoriteContainer: UIView?
    @IBOutlet weak var watchListContainer: UIView?

    var accountStates: MovieAccountStatesResult?
    var didUpdateMovieAccountState: UpdateMovieAccountState?

    override func awakeFromNib() {
        super.awakeFromNib()

        setupLayout()

        let favoriteTap = UITapGestureRecognizer(target: self, action: Selector(("favoriteAction")))
        favoriteContainer?.addGestureRecognizer(favoriteTap)

        let watchListTap = UITapGestureRecognizer(target: self, action: Selector(("watchListAction")))
        watchListContainer?.addGestureRecognizer(watchListTap)
    }

    func setupLayout() {
        guard let favoriteContainer = favoriteContainer,
            let watchListContainer = watchListContainer else { return }

        setupButtonLayout(favoriteContainer)
        setupButtonLayout(watchListContainer)
    }

    private func setupButtonLayout(_ view: UIView) {
        view.layer.borderWidth = 2
        view.layer.cornerRadius = view.frame.width / 2
        view.layer.borderColor = UIColor.white.cgColor
    }

    func configure(accountStates: MovieAccountStatesResult, didUpdateMovieAccountState: @escaping UpdateMovieAccountState) {
        self.accountStates = accountStates
        self.didUpdateMovieAccountState = didUpdateMovieAccountState

        updateFavoriteButton(favorite: accountStates.favorite)
        updateWatchlistButton(watchlist: accountStates.watchlist)

        userRateCircularView?.valueFormatter = VoteAverageFormatter()
        userRateCircularView?.style = .ontop
        userRateCircularView?.font = UIFont.boldSystemFont(ofSize: 11)
        userRateCircularView?.value = CGFloat(accountStates.validatedRated?.value ?? 0)
    }

    private func updateFavoriteButton(favorite: Bool) {
        favoriteButton?.tintColor = favorite ? UIColor(named: "favoriteSelected") : .white
    }

    private func updateWatchlistButton(watchlist: Bool) {
        watchListButton?.tintColor = watchlist ? UIColor(named: "watchListSelected") : .white
    }

    @IBAction func favoriteAction() {
        guard let accountStates = accountStates else { return }
        let movieId = accountStates.id

        let backgroundThread = ConcurrentDispatchQueueScheduler(qos: .background)

        let newState = !accountStates.favorite
        updateFavoriteButton(favorite: newState)

        FavoriteInteractor(favorite: newState, movieId: movieId)
            .execute()
            .flatMap { _ in GetMovieAccountStatesInteractor(movieId: movieId).execute() }
            .subscribeOn(backgroundThread)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                self?.didUpdateMovieAccountState?(result)
            },
            onError: { [weak self] error in
                self?.updateFavoriteButton(favorite: !newState)
            })
            .disposed(by: rx.disposeBag)
    }

    @IBAction func watchListAction() {
        guard let accountStates = accountStates else { return }
        let movieId = accountStates.id

        let backgroundThread = ConcurrentDispatchQueueScheduler(qos: .background)

        let newState = !accountStates.watchlist
        updateWatchlistButton(watchlist: newState)

        WatchlistInteractor(watchlist: newState, movieId: movieId)
            .execute()
            .flatMap { _ in GetMovieAccountStatesInteractor(movieId: movieId).execute() }
            .subscribeOn(backgroundThread)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                self?.didUpdateMovieAccountState?(result)
            },
            onError: { [weak self] error in
                self?.updateWatchlistButton(watchlist: !newState)
            })
            .disposed(by: rx.disposeBag)
    }
}
