//
//  KeyChainManager.swift
//  LHPPWallet
//
//  Created by sopheakneath on 17/4/26.
//

import Foundation

final class KeyChainManager {
    static let share = KeyChainManager()
    private init() {}
    
    func save(key: Data, for account: String) {
        let query: [String: Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : account,
            kSecValueData as String : key
        ]
        
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    func load(account: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String : account,
            kSecReturnData as String : true
            
        ]
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        return result as? Data
    }
    
    func delete(account: String)  {
        let query: [String : Any] = [
            kSecClass as String : kSecClassKey,
            kSecAttrAccount as String: account
        ]
        
       SecItemDelete(query as CFDictionary)
    }
   
    
}


