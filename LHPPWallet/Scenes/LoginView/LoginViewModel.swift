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
    @Published var showAlert: Bool = false
    @Published var alertMessage: String? = nil
    
    // Computed
    var isValid: Bool {
        !username.isEmpty && !password.isEmpty
    }
    
    // Actions
    func validate() {
        usernameError = username.isEmpty ? AppError.invalidData.localizedDescription : nil
        passwordError = password.isEmpty ? AppError.noData.localizedDescription : nil
        print("function validate")
    }
    
    func login() {
        if username.isEmpty && password.isEmpty {
            alertMessage = alertMessage ?? "Please fill in all fields."
            showAlert = true
            return
        }else{
            isLoggedIn = true
         
        }
    }
    
    func VALIDATE() {
        
        print("VALIDATE")
    }
}
