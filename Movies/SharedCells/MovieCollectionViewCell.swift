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

    func configure(movie: Movie) {
        coverImageView?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w200/\(movie.posterPath)"))
    }
}
