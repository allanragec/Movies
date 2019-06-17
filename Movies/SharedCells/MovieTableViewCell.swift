//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Allan Melo on 16/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit
import UICircularProgressRing

class MovieCellItem: CellItemController {
    let movie: Movie

    init(movie: Movie) {
        self.movie = movie
    }

    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let identifier = type(of: self).getIdentifier()

        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MovieTableViewCell
        cell?.configure(movie: movie)

        return cell ?? UITableViewCell(frame: .zero)
    }

    static func getIdentifier() -> String {
        return "MovieTableViewCell"
    }

    func openCell() {
        let movieDetailsViewController = MovieDetailsViewController(movie: movie)

        MVTabBarController.shared.currentNavigation()?
            .pushViewController(movieDetailsViewController, animated: true)
    }
}

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var coverImageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var genreLabel: UILabel?
    @IBOutlet weak var releaseDateLabel: UILabel?
    @IBOutlet weak var tokenView: TokensView?
    @IBOutlet weak var userScoreCircularView: UICircularProgressRing?
    @IBOutlet weak var coverWidthConstraint: NSLayoutConstraint?

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
        userScoreCircularView?.value = 0
    }

    func configure(movie: Movie) {
        titleLabel?.text = movie.originalTitle
        releaseDateLabel?.text = movie.getReleaseDate()
        genres = Settings.genres?.getTitles(ids: movie.genreIds) ?? []

        userScoreCircularView?.valueFormatter = VoteAverageFormatter()
        userScoreCircularView?.style = .ontop
        userScoreCircularView?.font = UIFont.boldSystemFont(ofSize: 9)
        userScoreCircularView?.value = CGFloat(movie.voteAverage)

        guard let posterPath = movie.posterPath else {
            coverWidthConstraint?.constant = 0
            return
        }

        coverWidthConstraint?.constant = 82
        coverImageView?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w200/\(posterPath)"))
    }
}
