//
//  Settings.swift
//  Movies
//
//  Created by Allan Melo on 13/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import Foundation

class Settings {
    static let TOKEN = "tkSSA"
    static let EMAIL = "email"
    static let EXPIRATION_DATE = "expirationDate"
    static let REQUEST_TOKEN = "requestToken"

    static let API_KEY = ""

    class var isLogged: Bool {
        return accessToken != nil
    }

    class var accessToken: String? {
        get {
            return preferences.value(forKey: TOKEN) as? String
        }
        set {
            preferences.set(newValue, forKey: TOKEN)
        }
    }

    class var email: String? {
        get {
            return preferences.value(forKey: EMAIL) as? String
        }
        set {
            preferences.set(newValue, forKey: EMAIL)
        }
    }

    class var requestToken: RequestTokenResult? {
        get {
            guard let data = preferences.value(forKey: REQUEST_TOKEN) as? Data else {
                return nil
            }

            return try? RequestTokenResult(with: data)
        }
        set {
            preferences.set(newValue.asData(), forKey: REQUEST_TOKEN)
        }
    }

    class func saveSession(email: String, accessToken: String, expirationDate: Double) {
        self.email = email
        self.accessToken = accessToken
    }

    class func clearSession() {
        email = nil
        accessToken = nil
    }

    class var preferences: UserDefaults {
        return UserDefaults.standard
    }
}


