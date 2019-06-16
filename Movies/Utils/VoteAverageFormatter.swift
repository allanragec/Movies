//
//  VoteAverageFormatter.swift
//  Movies
//
//  Created by Allan Melo on 16/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import Foundation
import UICircularProgressRing

class VoteAverageFormatter: UICircularRingValueFormatter {
    func string(for value: Any) -> String? {
        guard let value = value as? CGFloat else { return nil }

        if value == 0 {
            return "NR"
        }

        return String(format: "%.1f", value)
    }
}
