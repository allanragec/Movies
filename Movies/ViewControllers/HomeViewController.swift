//
//  HomeViewController.swift
//  Movies
//
//  Created by Allan Melo on 13/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView?

    lazy var viewModel = {
        return HomeViewModel(self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getResultsCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {

        return viewModel.getCell(at: indexPath)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.willDisplay(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margins: CGFloat = isLandscape ? 40 : 30

        let numberOfColumns: CGFloat = isLandscape ? 3 : 2

        let width = (collectionView.frame.width - margins) / numberOfColumns
        let height = (width / 20) * 30

        return CGSize(width: width, height: height)
    }
}
