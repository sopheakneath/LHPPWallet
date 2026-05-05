//
//  CryptoManager.swift
//  LHPPWallet
//
//  Created by sopheakneath on 17/4/26.
//

import CryptoKit
import Foundation

final class CryptoManager {
    static let share = CryptoManager()
    private init() {}
    
    func generateKey() -> SymmetricKey {
        return SymmetricKey(size: .bits256)
    }
    
    func encrypt(data: Data, key: SymmetricKey) throws -> Data {
        let sealedBox = try AES.GCM.seal(data, using: key)
        return sealedBox.combined!
    }
    
//    func decrypt(data: Data, key: SymmetricKey) throws -> Data {
//        let box = try AES.GCM.seal(data, using: key)
//        return try AES.GCM.open(box, using: key)
//    }
    
    func decrypt(data: Data, key: SymmetricKey) throws -> Data {
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        return try AES.GCM.open(sealedBox, using: key)
    }
    
}


