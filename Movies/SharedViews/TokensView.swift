//
//  TokensView.swift
//  Movies
//
//  Created by Allan Melo on 15/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit
import AlignedCollectionViewFlowLayout

class TokensView: UICollectionView {
    let cell = "TokenCollectionViewCell"

    var tokens: [String] = [] {
        didSet {
            reloadData()
        }
    }

    required init?(coder ADecoder: NSCoder) {
        super.init(coder: ADecoder)

        setup()
    }

    func setup() {
        let tokenNib = UINib(nibName: cell, bundle: nil)
        register(tokenNib, forCellWithReuseIdentifier: cell)

        delegate = self
        dataSource = self

        let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .center)

        alignedFlowLayout.minimumInteritemSpacing = 3
        alignedFlowLayout.minimumLineSpacing = 3

        collectionViewLayout = alignedFlowLayout
    }
}

extension TokensView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tokens.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell, for: indexPath)
            as? TokenCollectionViewCell,
            let genre = tokens.get(at: indexPath.row) else {
                return UICollectionViewCell()
        }

        cell.configure(title: genre)

        return cell
    }
}

extension TokensView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {

        guard let cell = self.collectionView(collectionView, cellForItemAt: indexPath)
            as? TokenCollectionViewCell else {
                return CGSize.zero
        }

        return cell.measuredSize
    }
}

