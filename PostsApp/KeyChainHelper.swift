//
//  LocalDataStore.swift
//  PostsApp
//
//  Created by Mohamed Elmalhey on 20/09/2025.
//

import Foundation
import Security
import LoginFeature

class KeyChainHelper {
    static let shared = KeyChainHelper()
    private init() {}
    var isLoggedIn: Bool {
        return getUser() != nil
    }
    
    private let userService = "com.postsapp.user"
    private let userAccount = "currentUser"

    func saveUser(_ user: LoginResponse) {
        if let data = try? JSONEncoder().encode(user) {
            saveToKeychain(data, service: userService, account: userAccount)
        }
    }

    func getUser() -> LoginResponse? {
        if let data = readFromKeychain(service: userService, account: userAccount) {
            return try? JSONDecoder().decode(LoginResponse.self, from: data)
        }
        return nil
    }

    func deleteUser() {
        deleteFromKeychain(service: userService, account: userAccount)
    }

    // MARK: - Keychain Methods
    private func saveToKeychain(_ data: Data, service: String, account: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    private func readFromKeychain(service: String, account: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var item: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &item)
        return item as? Data
    }

    private func deleteFromKeychain(service: String, account: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        SecItemDelete(query as CFDictionary)
    }
}
