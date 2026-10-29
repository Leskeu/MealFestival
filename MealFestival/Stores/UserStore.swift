//
//  UserStore.swift
//  MealFestival
//
//  Created by Jules Liegeois on 29/10/2026.
//

import Foundation
import Observation

@Observable
final class UserStore {

    private(set) var token: String?

    @ObservationIgnored
    private let keychainService = KeychainService()

    init() {
        self.token = keychainService.getToken()

        if token != nil {
            print("Token trouvé dans le Keychain")
        } else {
            print("Aucun token dans le Keychain")
        }
    }

    @discardableResult
    func setToken(token: String) -> Bool {

        guard keychainService.setToken(token) else {
            return false
        }

        self.token = token
        return true
    }

    func getToken() -> String? {
        return token
    }

    @discardableResult
    func deleteToken() -> Bool {

        guard keychainService.deleteToken() else {
            return false
        }

        self.token = nil
        return true
    }
}
