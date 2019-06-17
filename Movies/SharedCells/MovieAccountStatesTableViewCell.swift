//
//  MovieAccountStatesTableViewCell.swift
//  Movies
//
//  Created by Allan Melo on 16/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit
import UICircularProgressRing

class MovieAccountStatesCellItem: CellItemController {
    let accountStates: MovieAccountStatesResult

    init(accountStates: MovieAccountStatesResult) {
        self.accountStates = accountStates
    }

    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let identifier = type(of: self).getIdentifier()

        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MovieAccountStatesTableViewCell
        cell?.configure(accountStates: accountStates)

        return cell ?? UITableViewCell(frame: .zero)
    }

    static func getIdentifier() -> String {
        return "MovieAccountStatesTableViewCell"
    }

    func openCell() {}
}

class MovieAccountStatesTableViewCell: UITableViewCell {
    @IBOutlet weak var watchListButton: UIButton?
    @IBOutlet weak var favoriteButton: UIButton?
    @IBOutlet weak var userRateCircularView: UICircularProgressRing?
    @IBOutlet weak var favoriteContainer: UIView?
    @IBOutlet weak var watchListContainer: UIView?

    var accountStates: MovieAccountStatesResult?

    override func awakeFromNib() {
        super.awakeFromNib()

        setupLayout()
    }

    func setupLayout() {
        guard let favoriteContainer = favoriteContainer,
            let watchListContainer = watchListContainer else { return }

        setupButtonLayout(favoriteContainer)
        setupButtonLayout(watchListContainer)
    }

    private func setupButtonLayout(_ view: UIView) {
        view.layer.borderWidth = 2
        view.layer.cornerRadius = view.frame.width / 2
        view.layer.borderColor = UIColor.white.cgColor
    }

    func configure(accountStates: MovieAccountStatesResult) {
        self.accountStates = accountStates

        favoriteButton?.tintColor = accountStates.favorite ? UIColor(named: "favoriteSelected") : .white
        watchListButton?.tintColor = accountStates.watchlist ? UIColor(named: "watchListSelected") : .white

        userRateCircularView?.valueFormatter = VoteAverageFormatter()
        userRateCircularView?.style = .ontop
        userRateCircularView?.font = UIFont.boldSystemFont(ofSize: 11)
        userRateCircularView?.value = CGFloat(accountStates.validatedRated?.value ?? 0)
    }

    @IBAction func favoriteAction() {
    }

    @IBAction func watchListAction() {
    }
}
