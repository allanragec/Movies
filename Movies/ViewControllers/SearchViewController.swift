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

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar?.endEditing(true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        searchBar?.endEditing(true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
