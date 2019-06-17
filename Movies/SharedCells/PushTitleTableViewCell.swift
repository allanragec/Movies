//
//  PushTitleTableViewCell.swift
//  Movies
//
//  Created by Allan Melo on 17/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit

class PushTitleCellItem: CellItemController {

    let title: String
    var action: Action

    init (title: String, action: @escaping Action) {
        self.title = title
        self.action = action
    }

    static func getIdentifier() -> String {
        return "PushTitleTableViewCell"
    }

    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let identifier = type(of: self).getIdentifier()

        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PushTitleTableViewCell
        cell?.configure(title: title)

        return cell ?? UITableViewCell(frame: .zero)
    }

    func openCell() {
        action()
    }
}

class PushTitleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var rightImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        rightImage?.image = UIImage(named: "Forward")?.withRenderingMode(.alwaysTemplate)
        rightImage?.tintColor = .white
    }

    func configure(title: String) {
        titleLabel?.text = title
    }
}
