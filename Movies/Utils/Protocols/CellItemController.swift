//
//  CellItemController.swift
//  Movies
//
//  Created by Allan Melo on 15/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit

protocol CellItemController {
    static func getIdentifier() -> String
    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func openCell()
}

