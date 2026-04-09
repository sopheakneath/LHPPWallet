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
    @Published var username: String = "hi"
    @Published var password: String = "123"
    
    // Validation
    @Published var usernameError: String? = nil
    @Published var passwordError: String? = nil
    
    @Published var isSuccess: Bool = false

    // Navigation flag used by LoginView
    @Published var isLoggedIn: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String? = nil
    
    // Computed
    var isValid: Bool {
        !username.isEmpty && !password.isEmpty
    }

    func emptyData() -> Bool {
        usernameError = username.isEmpty || password.isEmpty ? AppError.noData.localizedDescription : nil
        return usernameError == nil && passwordError == nil
    }
    
    func validate() -> Bool {
        usernameError = username != "hi" ? AppError.invalidData.localizedDescription : nil
        passwordError = password != "123" ? AppError.invalidData.localizedDescription : nil
        return usernameError == nil && passwordError == nil
    }
    
    func login() {
        if !emptyData() {
            alertMessage = AppError.noData.localizedDescription
            showAlert = true
            return
        }
        
        if !validate() {
            alertMessage = AppError.invalidData.localizedDescription
            showAlert = true
            return
        }
        
        isLoggedIn = true
    }
    
    func VALIDATE() {
        
        print("VALIDATE")
    }
}

