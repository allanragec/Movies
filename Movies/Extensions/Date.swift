//
//  Date.swift
//  Movies
//
//  Created by Allan Melo on 15/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import Foundation

extension Date {
    func isTodayOrFuture() -> Bool {
        let now = Date().dateWithoutTime()

        return now.compare(self.dateWithoutTime()) == ComparisonResult.orderedAscending
    }

    func dateWithoutTime() -> Date {
        let dayFormatter = DateFormatter.dayFormatter
        let dateString = dayFormatter.string(from: self)

        return dayFormatter.date(from: dateString) ?? Date.minimumDate()
    }

    static func minimumDate() -> Date {
        return Date(timeIntervalSince1970: 0)
    }
}
