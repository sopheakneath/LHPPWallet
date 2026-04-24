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
    
    private let service = AuthenticationSevice()
    
    @Published var username = ""
    @Published var password = ""
    @Published var isLoading = false

    
    // Input
//    @Published var username: String = "hi"
//    @Published var password: String = "123"
    
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
    
    func loginSe() async {
            isLoading = true

            do {
                let user = try await service.login(username: username, password: password)
               
                print("username\(username)")

                // 🔐 Store token securely
                SecureStorage.share.save(value: user.token, for: "auth_token")
               // print("login success")
                isLoggedIn = true
                print("username encript\(username)")

            } catch {
                print("Login error:", error)
            }

            isLoading = false
        }
    
    
    
   
        func loginTestSecurity() async {
            isLoading = true
            do {
                let user = try await service.login(username: username, password: password)
                print("tocken before save\(user.token)")
                // 🔐 Save token
                SecureStorage.share.save(value: user.token, for: "auth_token")
                print("tocken\(user.token)")
                // ✅ Immediately verify
                let savedToken = SecureStorage.share.getValue(for: "auth_token")

                if savedToken == user.token {
                    alertMessage = "✅ Login + Secure Save SUCCESS"
                } else {
                    alertMessage = "❌ Token mismatch"
                }

            } catch {
                alertMessage = "❌ Login failed: \(error)"
            }

            isLoading = false
        }
    
    
    
    
}

