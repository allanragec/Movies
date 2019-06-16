//
//  SectionTitleTableViewCell.swift
//  Movies
//
//  Created by Allan Melo on 16/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit

class SectionTitleCellItem: CellItemController {
    let title: String

    init(title: String) {
        self.title = title
    }

    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let identifier = type(of: self).getIdentifier()

        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SectionTitleTableViewCell
        cell?.configure(title: title)

        return cell ?? UITableViewCell(frame: .zero)
    }

    static func getIdentifier() -> String {
        return "SectionTitleTableViewCell"
    }

    func openCell() {}
}

class SectionTitleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel?

    func configure(title: String) {
        titleLabel?.text = title
    }
}
