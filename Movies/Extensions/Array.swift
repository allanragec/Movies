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
        guard indices.contains(index) else { return nil }

        return self[index]
    }
}
