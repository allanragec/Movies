//
//  Array.swift
//  Movies
//
//  Created by Allan Melo on 14/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import Foundation

extension Array {
    public func get(at index: Int) -> Element? {
        guard (index + 1) <= count else {
            return nil
        }

        return self[index]
    }

}
