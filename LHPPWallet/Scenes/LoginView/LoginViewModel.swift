//
//  LoginViewModel.swift
//  LHPPWallet
//
//  Created by Sopheakneath on 22/3/26.
//

import Foundation
import SwiftUI
import Combine

final class LoginViewModel: ObservableObject {
    // Example of observable state for the login screen
    @Published var username: String = ""
    @Published var password: String = ""

    init() {
        // Safe place to perform side effects or initial logging
        print("LoginViewModel initialized")
    }
}
