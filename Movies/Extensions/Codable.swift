//
//  Codable.swift
//  Movies
//
//  Created by Allan Melo on 13/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import Foundation

enum CodableError: Error {
    case couldNotTransformJsonIntoData
}

extension Decodable {

    init(with data: Data) throws {
        self = try Self.decoder().decode(Self.self, from: data)
    }

    init(with json: [String: AnyObject]) throws {
        guard let data = json.toData() else {
            throw CodableError.couldNotTransformJsonIntoData
        }

        try self.init(with: data)
    }

    static func asArray(with data: Data) throws -> [Self] {
        return try Self.decoder().decode([Self].self, from: data)
    }

    private static func decoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(DateFormatter.defaultFormatter)

        return decoder
    }
}

extension Encodable {
    private static func encoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .formatted(DateFormatter.defaultFormatter)

        return encoder
    }

    func asDictionary() -> [String: Any] {
        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try encoder.encode(self)

            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return [String: Any]()
            }
            return dictionary
        }catch {
            return [String: Any]()
        }
    }

    func asData() -> Data? {
        return try? Self.encoder().encode(self)
    }
}

