//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Allan Melo on 14/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit
import SDWebImage
import AlignedCollectionViewFlowLayout

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var coverImageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var genreLabel: UILabel?
    @IBOutlet weak var releaseDateLabel: UILabel?
    @IBOutlet weak var tokenView: TokensView?

    var genres: [String] = [] {
        didSet {
            tokenView?.tokens = genres
            genreLabel?.isHidden = genres.isEmpty
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        tokenView?.tokens = []
        titleLabel?.text = nil
        releaseDateLabel?.text = nil
        coverImageView?.sd_cancelCurrentImageLoad()
        coverImageView?.image = nil
    }

    func configure(movie: Movie) {
        titleLabel?.text = movie.title
        releaseDateLabel?.text = movie.getReleaseDate() 
        genres = Settings.genres?.getTitles(ids: movie.genreIds) ?? []

        guard let posterPath = movie.posterPath else { return }

        coverImageView?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w200/\(posterPath)"))
    }
}
