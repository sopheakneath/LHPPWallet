//
//  SecureStorage.swift
//  LHPPWallet
//
//  Created by sopheakneath on 17/4/26.
//
import Foundation
import CryptoKit



final class SecureStorage {
    
    static let share = SecureStorage()
    private let keyTag = "com.LHPPWallet.secure"
    
    private init() {}
    
    private func getKey() -> SymmetricKey {
        if let keyData = KeyChainManager.share.load(account: keyTag) {
            return SymmetricKey(data: keyData)
        } else {
            let key = CryptoManager.share.generateKey()
            let data = key.withUnsafeBytes { Data($0) }
            KeyChainManager.share.save(key: data, for: keyTag)
            return key
        }
    }
    
    /// Saves an encrypted value for the given key in UserDefaults
    func save(value: String, for key: String) {
        let encryptionKey = getKey()
        guard let data = value.data(using: .utf8), let encrypted = try? CryptoManager.share.encrypt(data: data, key: encryptionKey) else { return }
       
        
        UserDefaults.standard.set( encrypted, forKey: key )
        print("🔐 Encrypted data:", encrypted.base64EncodedString())
    }
    
    func getValue(for key: String) -> String? {
        let encryptionKey = getKey()
        guard let encrypted = UserDefaults.standard.data(forKey: key), let decrypted = try? CryptoManager.share.decrypt(data: encrypted, key: encryptionKey) else { return nil }
        print("🔐 decrypted data:", decrypted.base64EncodedString())
        return String(data: decrypted, encoding: .utf8)
        
    }
    
    func delete(key: String) {
        UserDefaults.standard.removeObject(forKey: key )
    }
}



//get plain text from api
//stare in keychain as encrypt Data
//get data by decrypt all data and show real data on app
//
