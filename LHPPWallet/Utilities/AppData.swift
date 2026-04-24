//
//  AppData.swift
//  LHPPWallet
//
//  Created by sopheakneath on 23/4/26.
//


import SwiftUI

/// Describes the next screen to navigate to after OTP verification
enum OTPDestination: Equatable {
    case registrationSuccess
    case registrationFlow
    case transferSuccess
    case resetPasswordFlow
}

enum OTPSource {
    case register
    case transfer
    case resetPassword
}

extension OTPSource {
    
    var title: String {
        switch self {
        case .register:
            return "Register"
        case .transfer:
            return "Confirm Transfer"
        case .resetPassword:
            return "Reset Password"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .register:
            return "Verify Account"
        case .transfer:
            return "Confirm"
        case .resetPassword:
            return "Continue"
        }
    }
   
    /// The next screen to navigate to after OTP validation, depending on source
    var nextDestination: OTPDestination {
        switch self {
        case .register:
            return .registrationSuccess
        case .transfer:
            return .transferSuccess
        case .resetPassword:
            return .resetPasswordFlow
        }
    }
}
