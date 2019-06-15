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
}
