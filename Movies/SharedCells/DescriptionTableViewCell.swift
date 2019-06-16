//
//  DescriptionTableViewCell.swift
//  Movies
//
//  Created by Allan Melo on 16/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit

class DescriptionCellItem: CellItemController {
    let description: String

    init(description: String) {
        self.description = description
    }

    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let identifier = type(of: self).getIdentifier()

        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DescriptionTableViewCell
        cell?.configure(description: description)

        return cell ?? UITableViewCell(frame: .zero)
    }

    static func getIdentifier() -> String {
        return "DescriptionTableViewCell"
    }

    func openCell() {}
}

class DescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel?

    func configure(description: String) {
        descriptionLabel?.text = description
    }
}
