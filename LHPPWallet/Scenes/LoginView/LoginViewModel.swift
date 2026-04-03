//
//  LoginViewModel.swift
//  LHPPWallet
//
//  Created by Sopheakneath on 22/3/26.
//

import Foundation
import SwiftUI
import Combine


class LoginViewModel: ObservableObject {
    
    // Input
    @Published var username: String = ""
    @Published var password: String = ""
    
    // Validation
    @Published var usernameError: String? = nil
    @Published var passwordError: String? = nil
    
    @Published var isSuccess: Bool = false

    // Navigation flag used by LoginView
    @Published var isLoggedIn: Bool = false
    
    // Computed
    var isValid: Bool {
        !username.isEmpty && !password.isEmpty
    }
    
    // Actions
    func validate() {
        usernameError = username.isEmpty ? "Username is required" : nil
        passwordError = password.isEmpty ? "Password is required" : nil
    }
    
    func login() {
        validate()
        guard isValid else { return }
        isSuccess = true
        isLoggedIn = true
        
        // Call API
        print("Login with \(username), \(password)")
    }
}
