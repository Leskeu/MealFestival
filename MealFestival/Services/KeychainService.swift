//
//  KeychainService.swift
//  MealFestival
//
//  Created by Jules Liegeois on 29/10/2026.
//
import Foundation
import Security

@Observable
class KeychainService {
    
    private let service = "MealFestival"
    private let account = "authToken"
    private(set) var token: String?

    @discardableResult
    func setToken(_ token: String) -> Bool {

        //trasnform token string into token data
        guard let tokenData = token.data(using: .utf8) else {
            return false
        }

        //create query for save token
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]

        //add token to query
        let attributes: [String: Any] = [
            kSecValueData as String: tokenData
        ]

        //try to edit previous token
        let updateStatus = SecItemUpdate(
            query as CFDictionary,
            attributes as CFDictionary
        )

        if updateStatus == errSecSuccess {
            return true
        }

        //try to create token place in keychain
        guard updateStatus == errSecItemNotFound else {
            print("Erreur Keychain : \(updateStatus)")
            return false
        }

        //create query to create token
        var newQuery = query
        newQuery[kSecValueData as String] = tokenData
        newQuery[kSecAttrAccessible as String] =
            kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly

        //add token in keychain
        let addStatus = SecItemAdd(
            newQuery as CFDictionary,
            nil
        )

        return addStatus == errSecSuccess
    }

    
    func getToken() -> String? {

        //query to get token
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: CFTypeRef?

        //try getting token
        let status = SecItemCopyMatching(
            query as CFDictionary,
            &result
        )

        //check token
        guard status == errSecSuccess,
              let tokenData = result as? Data,
              let token = String(data: tokenData, encoding: .utf8)
        else {
            return nil
        }

        return token
    }
    
    @discardableResult
    func deleteToken() -> Bool {

        //create query to delete tokejn
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]

        //try to delete token
        let status = SecItemDelete(query as CFDictionary)

        return status == errSecSuccess ||
               status == errSecItemNotFound
    }
}
