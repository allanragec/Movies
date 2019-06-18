//
//  UIViewController.swift
//  Movies
//
//  Created by Allan Melo on 14/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit

extension UIViewController {
    func removeBackTitle() {
        navigationController?.navigationBar.topItem?.title = "";
    }

    func showInternetAlertError() {
        let alert = UIAlertController(title: "Alert",
                                      message: "Something is wrong.. can you check your internet connection?",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default))

        present(alert, animated: true)
    }
}
