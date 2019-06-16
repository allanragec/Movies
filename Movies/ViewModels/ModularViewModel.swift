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
    func isCollapsibleHeaderView() -> Bool
    func getAsCollapsibleHeaderView() -> CollapsibleHeaderView?
}

extension ModularViewModel {
    func open(for index: IndexPath) {
        let items = getItems()

        guard let item = items.get(at: index.row)  else { return }

        item.openCell()
    }

    func createCell(for index: IndexPath) -> UITableViewCell {
        let items = getItems()

        guard let tableView = getTableView(),
            let item = items.get(at: index.row)
            else { return UITableViewCell(frame: CGRect.zero) }

        return item.cell(tableView: tableView, indexPath: index)
    }

    func isCollapsibleHeaderView() -> Bool {
        return self is CollapsibleHeaderView
    }

    func getAsCollapsibleHeaderView() -> CollapsibleHeaderView? {
        return self as? CollapsibleHeaderView
    }
}

//MARK: Collapsible Header View

protocol CollapsibleHeaderView {
    func getHeaderView() -> UIView?
    func getHeaderHeightConstraint() -> NSLayoutConstraint?
    func getMaximumHeaderSize() -> CGFloat
    func getPinnedHeaderSize() -> CGFloat
    func getScrollableHeaderSize() -> CGFloat
    func getHalfHeaderSize() -> CGFloat
}

extension CollapsibleHeaderView {
    func getScrollableHeaderSize() -> CGFloat {
        return getMaximumHeaderSize() - getPinnedHeaderSize()
    }

    func getHalfHeaderSize() -> CGFloat {
        return getPinnedHeaderSize() + (getScrollableHeaderSize() / 2)
    }
}
