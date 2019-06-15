//
//  UIResponder.swift
//  Movies
//
//  Created by Allan Melo on 14/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit

extension UIResponder {
    static var className: String {
        return String(describing: self)
    }

    var isLandscape: Bool {
        return UIDevice.current.orientation.isLandscape
    }
}
