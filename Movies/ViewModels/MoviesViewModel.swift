//
//  HomeViewModel.swift
//  Movies
//
//  Created by Allan Melo on 14/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift

class MoviesViewModel {

    weak var viewController: MoviesViewController?

    let cell = MovieCollectionViewCell.className

    var results: [Movie] = []
    var lastResult: MoviesResult?

    var moviesDisposable: Disposable? {
        didSet {
            if moviesDisposable != nil {
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

    init(_ viewController: MoviesViewController) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        let nibCell = UINib(nibName: cell, bundle: nil)

        viewController?.collectionView?.register(nibCell, forCellWithReuseIdentifier: cell)

        viewController?.navigationController?.navigationBar.isHidden = true

        if let customTitle = viewController?.customTitle {
            viewController?.titleLabel?.text = customTitle
            viewController?.titleHeightConstraint?.constant = 60
        }

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
        let hasRequestRunning = moviesDisposable != nil

        if needToShowMore(row: indexPath.row) && !hasRequestRunning {
            loadMovies()
        }
    }

    func didSelectItem(at indexPath: IndexPath) {
        guard let movie = results.get(at: indexPath.row) else { return }

        let movieDetailsViewController = MovieDetailsViewController(movie: movie)
        viewController?.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func sizeForItem(at indexPath: IndexPath) -> CGSize {
        guard let viewController = viewController,
            let collectionView = viewController.collectionView else {
                return CGSize.zero
        }

        let isLandscape = viewController.isLandscape

        let margins: CGFloat = isLandscape ? 40 : 30

        let numberOfColumns: CGFloat = isLandscape ? 3 : 2

        let width = (collectionView.frame.width - margins) / numberOfColumns
        let height = (width / 20) * 30

        return CGSize(width: width, height: height)
    }

    // MARK: - Util

    private func needToShowMore(row: Int) -> Bool {
        let treshHolderLimit = 5
        let remainingItemsCount = results.count - row

        return remainingItemsCount < treshHolderLimit
    }

    // MARK: - URL tasks

    private func loadMovies() {
        let nextPage = (lastResult?.page ?? 0) + 1
        let totalPages = lastResult?.totalPages ?? 1

        guard nextPage <= totalPages else {
            return
        }

        let backgroundThread = ConcurrentDispatchQueueScheduler(qos: .background)

        moviesDisposable = viewController?
            .loaderMovies
            .getObservable(page: nextPage)
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
                self?.moviesDisposable = nil
            },
            onCompleted: { [weak self] in
                self?.moviesDisposable = nil

                guard let strongSelf = self,
                    let collectionView = strongSelf.viewController?.collectionView,
                    let lastIndexPath = collectionView.indexPathsForVisibleItems.last
                    else { return }

                if strongSelf.needToShowMore(row: lastIndexPath.row) {
                    strongSelf.loadMovies()
                }
            })
    }
}
