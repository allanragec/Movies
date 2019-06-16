//
//  SearchViewModel.swift
//  Movies
//
//  Created by Allan Melo on 16/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift
import RxCocoa
import NSObject_Rx

class SearchViewModel {

    weak var viewController: SearchViewController?

    var items: [CellItemController] = [] {
        didSet {
            updateData()
        }
    }

    init(_ viewController: SearchViewController) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        guard let viewController = viewController else { return }

        viewController.navigationController?.navigationBar.isHidden = true
        registerCellItems()

        searchSubscribe()
    }

    func searchSubscribe() {
        guard let viewController = viewController else { return }

        let backgroundThread = ConcurrentDispatchQueueScheduler(qos: .background)

        viewController.searchBar?.rx.text
            .asObservable()
            .skip(1)
            .debounce(0.4, scheduler: MainScheduler.instance)
            .map { $0 ?? "" }
            .distinctUntilChanged { textBefore, textAfter in
                let textBeforeTrimmed = textBefore.trimmingCharacters(
                    in: CharacterSet.whitespacesAndNewlines)

                let textAfterTrimmed = textAfter.trimmingCharacters(
                    in: CharacterSet.whitespacesAndNewlines)

                return textBeforeTrimmed == textAfterTrimmed
            }
            .filter{ query in
                if query.count > 2 {
                    return true
                }

                self.items = []

                return false
            }
            .do(onNext: { _ in viewController.activityIndicator?.startAnimating() })
            .flatMap { SearchMoviesInteractor(query: $0).execute() }
            .map { result in result.results.map { MovieCellItem(movie: $0) } }
            .subscribeOn(backgroundThread)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { movies in
                self.items = movies
            }, onError: { error in
                self.verifyError(error)
            })
            .disposed(by: viewController.rx.disposeBag)
    }

    func refresh() {
        viewController?.refreshControl.endRefreshing()
    }

    private func updateData() {
        guard let viewController = viewController else { return }

        viewController.tableView?.reloadData()
        viewController.activityIndicator?.stopAnimating()
    }

    private func verifyError(_ error: Error) {
        print("Search error \(error)")
        viewController?.activityIndicator?.stopAnimating()

        searchSubscribe()
    }
}

extension SearchViewModel: ModularViewModel {
    func registerCellItems() {
        getTableView()?.register(cellController: MovieCellItem.self)
    }

    func getTableView() -> UITableView? {
        return viewController?.tableView
    }

    func getItems() -> [CellItemController] {
        return items
    }
}


