//
//  Settings.swift
//  Movies
//
//  Created by Allan Melo on 13/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import Foundation
import KeychainSwift

class Settings {
    static let TOKEN = "tkSSA"
    static let EMAIL = "email"
    static let EXPIRATION_DATE = "expirationDate"
    static let REQUEST_TOKEN = "requestToken"
    static let USER_ACCOUNT = "userAccount"

    static let API_KEY = ""

    class var isLogged: Bool {
        return sessionId != nil
    }

    class var sessionId: String? {
        get {
            let keychain = KeychainSwift()

            return keychain.get(TOKEN)
        }
        set {
            let keychain = KeychainSwift()

            if let newValue = newValue {
                keychain.set(newValue, forKey: TOKEN)
            }
            else {
                keychain.delete(TOKEN)
            }
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

    class var userAccount: AccountResult? {
        get {
            guard let data = preferences.value(forKey: USER_ACCOUNT) as? Data else {
                return nil
            }

            return try? AccountResult(with: data)
        }
        set {
            preferences.set(newValue.asData(), forKey: USER_ACCOUNT)
        }
    }

    class func saveSession(email: String, accessToken: String, expirationDate: Double) {
        self.email = email
        self.sessionId = accessToken
    }

    class func clearSession() {
        email = nil
        sessionId = nil
        requestToken = nil
        userAccount = nil
    }

    class var preferences: UserDefaults {
        return UserDefaults.standard
    }
}


