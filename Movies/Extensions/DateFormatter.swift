//
//  DateFormatter.swift
//  Movies
//
//  Created by Allan Melo on 13/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import Foundation

extension DateFormatter
{
    @nonobjc static let defaultFormatter = DateFormatter.formatter("yyyy-MM-dd hh:mm:ss Z")

    class func formatter(_ format:String) -> DateFormatter
    {
        let formatter = DateFormatter()

        formatter.dateFormat = format

        return formatter
    }
}

