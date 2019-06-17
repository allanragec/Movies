//
//  ButtonTableViewCell.swift
//  Movies
//
//  Created by Allan Melo on 17/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit

typealias Action = () -> Void

class ButtonCellItem: CellItemController {

    let title: String
    var action: Action

    init (title: String, action: @escaping Action) {
        self.title = title
        self.action = action
    }

    static func getIdentifier() -> String {
        return "ButtonTableViewCell"
    }

    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let identifier = type(of: self).getIdentifier()

        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ButtonTableViewCell
        cell?.configure(title: title, action: action)

        return cell ?? UITableViewCell(frame: .zero)
    }

    func openCell() {}
}

class ButtonTableViewCell: UITableViewCell {
    @IBOutlet weak var button: UIButton?

    var action: Action?

    func configure(title: String, action: @escaping Action) {
        button?.setTitle(title, for: .normal)
        self.action = action
    }
    @IBAction func buttonAction(_ sender: Any) {
        action?()
    }
}
