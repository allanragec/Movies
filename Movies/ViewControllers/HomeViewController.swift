//
//  HomeViewController.swift
//  Movies
//
//  Created by Allan Melo on 13/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift
import NSObject_Rx

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView?

    let cell = "MovieCollectionViewCell"

    var results: [Movie] = []
    var currentPage = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Upcoming"

        collectionView?.register(UINib(nibName: cell, bundle: nil), forCellWithReuseIdentifier: cell)

        let backgroundThread = ConcurrentDispatchQueueScheduler(qos: .background)

        loadingActivityIndicator?.startAnimating()
        
        GetUpcomingMoviesInteractor(page: currentPage)
            .execute()
            .subscribeOn(backgroundThread)
            .observeOn(MainScheduler.instance)
            .subscribe(
            onNext: { [weak self] result in
                self?.results += result.results
                self?.collectionView?.reloadData()
                self?.currentPage += 1
            },
            onError: { error in
                print(error)
            },
            onCompleted: { [weak self] in
                self?.loadingActivityIndicator?.stopAnimating()
            })
            .disposed(by: rx.disposeBag)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell, for: indexPath)
            as? MovieCollectionViewCell,
            let movie = results.get(at: indexPath.row) else {
            return UICollectionViewCell()
        }

        cell.configure(movie: movie)

        return cell
    }
}
