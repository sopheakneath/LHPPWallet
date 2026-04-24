//
//  authenticationService.swift
//  LHPPWallet
//
//  Created by sopheakneath on 17/4/26.
//
//import Combine
import Foundation


class AuthenticationSevice {
    static let shared = AuthenticationSevice()
    
    func getNotifications(completion: @escaping ([TransactionModel]) -> ()) {
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.init(TransactionModel.mock))
        }}
    
    
   

        func login(username: String, password: String) async throws -> UserModel {
            // Mock API
            return UserModel(id: "123", token: "secure_token_abc")
        }
    
}
