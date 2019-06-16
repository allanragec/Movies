//
//  UITableView.swift
//  Movies
//
//  Created by Allan Melo on 16/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: CellItemController>(cellController: T.Type) {
        let identifier = cellController.getIdentifier()
        let nibCell = UINib(nibName: identifier, bundle: nil)
        register(nibCell, forCellReuseIdentifier: identifier)
    }
}
