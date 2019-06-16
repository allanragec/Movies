//
//  LoaderDataFromServer.swift
//  Movies
//
//  Created by Allan Melo on 13/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift

class LoaderDataFromServer {
    func createObservable(url: String, httpMethod: String = "GET", body: Data? = nil,
                          headers: [String: String] = [:]) -> Observable<Data> {

        return Observable.create{ observer in
            guard let url = URL(string: url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? "") else {
                observer.onError(ServerErrors.invalidRequest)

                return Disposables.create {}
            }

            let configuration = URLSession.shared.configuration
            configuration.timeoutIntervalForRequest = 10

            var request = URLRequest(url: url)
            request.httpMethod = httpMethod
            request.httpBody = body
            var headers = headers
            headers["Content-Type"] = "application/json"
            request.allHTTPHeaderFields = headers

            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                guard let data = data, error == nil else {
                    observer.onError(error ?? ServerErrors.connectionError)

                    return
                }

                observer.onNext(data)
                observer.onCompleted()
            })

            task.resume()

            return Disposables.create {
                task.suspend()
            }
        }
    }
}


