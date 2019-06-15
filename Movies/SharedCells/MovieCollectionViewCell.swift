//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Allan Melo on 14/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var coverImageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?

    override func prepareForReuse() {
        super.prepareForReuse()

        titleLabel?.text = nil
        coverImageView?.sd_cancelCurrentImageLoad()
        coverImageView?.image = nil
    }

    func configure(movie: Movie) {
        titleLabel?.text = movie.title

        guard let posterPath = movie.posterPath else { return }

        coverImageView?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w200/\(posterPath)"))
    }
}
