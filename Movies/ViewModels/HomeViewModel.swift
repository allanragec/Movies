//
//  HomeViewModel.swift
//  Movies
//
//  Created by Allan Melo on 14/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift

class HomeViewModel {

    weak var viewController: HomeViewController?

    let cell = MovieCollectionViewCell.className

    var results: [Movie] = []
    var lastResult: UpcomingMoviesResult?

    var upcomingMoviesDisposable: Disposable? {
        didSet {
            if upcomingMoviesDisposable != nil {
                if results.isEmpty {
                    viewController?.loadingActivityIndicator?.startAnimating()
                }

                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
            else {
                viewController?.loadingActivityIndicator?.stopAnimating()

                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }

    // MARK: - LifeCycle

    init(_ viewController: HomeViewController) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        let nibCell = UINib(nibName: cell, bundle: nil)

        viewController?.collectionView?.register(nibCell, forCellWithReuseIdentifier: cell)

        loadMovies()
    }

    // MARK: - UICollectionViewDataSource

    func getResultsCount() -> Int {
        return results.count
    }

    func getCell(at indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let collectionView = viewController?.collectionView,
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell, for: indexPath)
                as? MovieCollectionViewCell,
            let movie = results.get(at: indexPath.row) else {

                return UICollectionViewCell()
        }

        cell.configure(movie: movie)

        return cell
    }

    // MARK: - UICollectionViewDelegate

    func willDisplay(at indexPath: IndexPath) {
        let treshHolderLimit = 5
        let remainingItemsCount = results.count - indexPath.row
        let hasRequestRunning = upcomingMoviesDisposable != nil

        if (remainingItemsCount < treshHolderLimit) && !hasRequestRunning {
            loadMovies()
        }
    }

    func didSelectItem(at indexPath: IndexPath) {
        guard let movie = results.get(at: indexPath.row) else { return }

        let movieDetailsViewController = MovieDetailsViewController(movie: movie)
        viewController?.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }

    // MARK: - URL tasks

    private func loadMovies() {
        let nextPage = (lastResult?.page ?? 0) + 1
        let totalPages = lastResult?.totalPages ?? 1

        guard nextPage <= totalPages else {
            return
        }

        let backgroundThread = ConcurrentDispatchQueueScheduler(qos: .background)

        upcomingMoviesDisposable = GetUpcomingMoviesInteractor(page: nextPage)
            .execute()
            .subscribeOn(backgroundThread)
            .observeOn(MainScheduler.instance)
            .subscribe(
            onNext: { [weak self] result in
                self?.results += result.results
                self?.viewController?.collectionView?.reloadData()
                self?.lastResult = result
            },
            onError: { [weak self] error in
                print(error)
                self?.upcomingMoviesDisposable = nil
            },
            onCompleted: { [weak self] in
                self?.upcomingMoviesDisposable = nil
            })
    }
}
