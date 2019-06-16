//
//  SearchViewController.swift
//  Movies
//
//  Created by Allan Melo on 16/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit

class SearchViewController: ModularViewController<SearchViewModel> {
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?

    lazy var viewModel = {
        return SearchViewModel(self)
    }()

    override func getTableView() -> UITableView? {
        return tableView
    }

    override func getViewModel() -> SearchViewModel {
        return viewModel
    }
}
