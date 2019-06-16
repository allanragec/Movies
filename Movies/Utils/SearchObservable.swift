//
//  SearchObservable.swift
//  Movies
//
//  Created by Allan Melo on 16/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift

class SearchObservable {
    class func configure(_ observable: Observable<String?>) -> Observable<String> {
        return observable
            .skip(1)
            .debounce(0.4, scheduler: MainScheduler.instance)
            .map { $0 ?? "" }
            .distinctUntilChanged { textBefore, textAfter in
                let textBeforeTrimmed = textBefore.trimmingCharacters(
                    in: CharacterSet.whitespacesAndNewlines)

                let textAfterTrimmed = textAfter.trimmingCharacters(
                    in: CharacterSet.whitespacesAndNewlines)

                return textBeforeTrimmed == textAfterTrimmed
            }
    }
}
