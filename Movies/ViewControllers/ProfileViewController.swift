//
//  ProfileViewController.swift
//  Movies
//
//  Created by Allan Melo on 13/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView?
    @IBOutlet weak var profileLabel: UILabel?
    @IBOutlet weak var loginLogouButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
    }

    @IBAction func loginAction() {
        if Settings.isLogged {
            Settings.clearSession()
            setupLayout()
        }
        else {
            navigationController?.present(LoginViewController(), animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupLayout()
    }

    private func setupLayout() {
        let isLogged = Settings.isLogged

        loginLogouButton?.setTitle(Settings.isLogged ? "Logout" : "Login", for: .normal)

        if isLogged {
            let userAccount = Settings.userAccount
            let gravatarHash = userAccount?.avatar?.gravatar?.hash ?? ""

            profileImage?.sd_setImage(with: URL(string: "https://www.gravatar.com/avatar/\(gravatarHash)"))
            profileLabel?.text = userAccount?.username
        }
        else {
            profileImage?.image = nil
            profileLabel?.text = nil
        }
    }
}
