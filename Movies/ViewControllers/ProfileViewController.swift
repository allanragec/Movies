//
//  ProfileViewController.swift
//  Movies
//
//  Created by Allan Melo on 13/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileViewController: ModularViewController<ProfileViewModel> {
    @IBOutlet weak var profileImage: UIImageView?
    @IBOutlet weak var profileLabel: UILabel?
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var headerView: UIView?
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint?

    lazy var viewModel = {
        return ProfileViewModel(self)
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.viewWillAppear()
    }

    override func getTableView() -> UITableView? {
        return tableView
    }

    override func getViewModel() -> ProfileViewModel {
        return viewModel
    }
}
