//
//  Observable.swift
//  Movies
//
//  Created by Allan Melo on 13/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift
import RxBlocking

extension Observable {
    func result() -> Element? {
        do {
            return try self.asObservable().toBlocking().single()
        }
        catch let error {
            print(error)

            return nil
        }
    }
}
