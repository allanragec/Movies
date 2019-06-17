//
//  ProfileViewModel.swift
//  Movies
//
//  Created by Allan Melo on 17/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileViewModel {

    weak var viewController: ProfileViewController?

    // MARK: - LifeCycle

    init(_ viewController: ProfileViewController) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        viewController?.navigationController?.navigationBar.isHidden = true
    }

    func viewWillAppear() {
        setupHeaderView()
        getTableView()?.reloadData()
    }

    private func setupHeaderView() {
        guard let viewController = viewController else { return }

        let isLogged = Settings.isLogged

        if isLogged {
            let userAccount = Settings.userAccount
            let gravatarHash = userAccount?.avatar?.gravatar?.hash ?? ""

            viewController.profileImage?.sd_setImage(
                with: URL(string: "https://www.gravatar.com/avatar/\(gravatarHash)"))
            viewController.profileLabel?.text = userAccount?.username
        }
        else {
            viewController.profileImage?.image = UIImage(named: "person")
            viewController.profileLabel?.text = nil
        }
    }

    private func loginAction() {
        if Settings.isLogged {
            Settings.clearSession()
            setupHeaderView()
            getTableView()?.reloadData()
        }
        else {
            viewController?.navigationController?.present(LoginViewController(), animated: true)
        }
    }

    private func verifyError(_ error: Error) {
        print("error \(error)")
    }
}

extension ProfileViewModel: ModularViewModel {
    func refresh() {
        viewController?.refreshControl.endRefreshing()
    }

    func registerCellItems() {
        getTableView()?.register(cellController: ButtonCellItem.self)
    }

    func getTableView() -> UITableView? {
        return viewController?.tableView
    }

    func getItems() -> [CellItemController] {
        var cellItems = [CellItemController]()

        let loginButtonTitle = Settings.isLogged ? "Logout" : "Login"
        cellItems.append(ButtonCellItem(title: loginButtonTitle, action: { [weak self] in
            self?.loginAction()
        }))

        return cellItems
    }
}

extension ProfileViewModel: CollapsibleHeaderView {
    func getHeaderView() -> UIView? {
        return viewController?.headerView
    }

    func getHeaderHeightConstraint() -> NSLayoutConstraint? {
        return viewController?.headerViewHeightConstraint
    }

    func getMaximumHeaderSize() -> CGFloat {
        return 150
    }

    func getPinnedHeaderSize() -> CGFloat {
        return 100
    }
}
