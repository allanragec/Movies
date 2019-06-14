//
//  LoaderObservable.swift
//  Movies
//
//  Created by Allan Melo on 13/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift

protocol LoaderCodableObservable  {
    associatedtype T : Codable

    func getUrl() -> String
    func createObservable() -> Observable<T>
    func getHttpMethod() -> String
    func getBody() -> Data?
    func getHeaders() -> [String: String]
}

extension LoaderCodableObservable {
    func createObservable() -> Observable<T> {
        return LoaderDataFromServer()
            .createObservable(url: getUrl(),
                              httpMethod: getHttpMethod(),
                              body: getBody(),
                              headers: getHeaders())
            .map { try T(with: $0) }
    }

    func getHttpMethod() -> String {
        return "GET"
    }

    func getBody() -> Data? {
        return nil
    }

    func getHeaders() -> [String: String] {
        return [:]
    }
}

protocol LoaderDataObservable  {
    func getUrl() -> String
    func createDataObservable() -> Observable<Data>
}

extension LoaderDataObservable {
    func createDataObservable() -> Observable<Data> {
        return LoaderDataFromServer()
            .createObservable(url: getUrl())
    }
}




