//
//  ModularViewModel.swift
//  Movies
//
//  Created by Allan Melo on 15/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit

protocol ModularViewModel {
    func registerCellItems()
    func viewDidLoad()
    func refresh()
    func getTableView() -> UITableView?
    func getItems() -> [CellItemController]
    func createCell(for index: IndexPath) -> UITableViewCell
    func open(for index: IndexPath)
}

extension ModularViewModel {
    func open(for index: IndexPath) {
        let items = getItems()

        guard let item = items.get(at: index.row)  else { return }

        item.openCell()
    }

    func createCell(for index: IndexPath) -> UITableViewCell {
        let items = getItems()

        guard let tableView = getTableView(), index.row < items.count else { return UITableViewCell(frame: CGRect.zero) }

        let item = items[index.row]

        return item.cell(tableView: tableView, indexPath: index)
    }
}

