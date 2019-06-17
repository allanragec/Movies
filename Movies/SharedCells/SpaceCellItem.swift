//
//  SpaceCellItem.swift
//  Movies
//
//  Created by Allan Melo on 17/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit

class SpaceCellItem: CellItemController {

    let space: CGFloat

    init (space: CGFloat) {
        self.space = space
    }

    static func getIdentifier() -> String {
        return ""
    }

    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let rect = CGRect(x: 0, y: 0, width: 0, height: space)

        let cell = UITableViewCell(frame: rect)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear

        return cell
    }

    func openCell() {}
}
