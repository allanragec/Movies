//
//  MoviesViewController.swift
//  Movies
//
//  Created by Allan Melo on 13/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit
import RxSwift

class MoviesViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var titleHeightConstraint: NSLayoutConstraint?
    @IBOutlet weak var emptyLabel: UILabel?
    
    lazy var viewModel = {
        return MoviesViewModel(self)
    }()

    let loaderMovies: LoaderMovies
    let customTitle: String?
    let needToReloadOnWillAppear: Bool

    init(loaderMovies: LoaderMovies, title: String? = nil, needToReloadOnWillAppear: Bool = false) {
        self.loaderMovies = loaderMovies
        self.customTitle = title
        self.needToReloadOnWillAppear = needToReloadOnWillAppear
        
        super.init(nibName: "MoviesViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.viewWillAppear()
    }

    @IBAction func backButton() {
        navigationController?.popViewController(animated: true)
    }
}

extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getResultsCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {

        return viewModel.getCell(at: indexPath)
    }
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        viewModel.willDisplay(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return viewModel.sizeForItem(at: indexPath)
    }
}
