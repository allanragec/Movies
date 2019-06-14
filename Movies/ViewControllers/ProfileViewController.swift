//
//  ProfileViewController.swift
//  Movies
//
//  Created by Allan Melo on 13/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBAction func loginAction() {
        navigationController?.present(LoginViewController(), animated: true)
    }
}
