//
//  OTPViewModel.swift
//  LHPPWallet
//
//  Created by sopheakneath on 23/3/26.
//

import Foundation
import SwiftUI
import Combine

class OTPViewModel: ObservableObject {
    
    @Published var otp: [String] = Array(repeating: "", count: 6)
    @Published var pin:[String] = Array(repeating: "", count: 4)
    
    var otpCode: String {
        // combine all digit together
        otp.joined()
    }
     
    var isComplete: Bool {
        !otp.contains { $0.isEmpty }
        
    }
    
    func update(value: String, at index: Int) {
        guard index < otp.count else { return }
        guard index < pin.count else { return }
        
        if value.count > 1 {
            // paste case
            let values = Array(value.prefix(otp.count)).map { String($0) }
            let valuePin = Array(value.prefix(pin.count)).map { String($0)}
            for i in 0..<values.count {
                otp[i] = values[i]
            }
            for i in 0..<valuePin.count {
                pin[i] = valuePin[i]
            }
            
            print("new value \(value)")
        } else {
            otp[index] = value
            pin[index] = value
        
        }
    }
    
    func clear(at index: Int) {
        guard index < otp.count else { return }
        otp[index] = ""
    }
    
    func verifyOTP() {
        guard isComplete else { return }
        let defualtOTP = "123456"
        
       // print("OTP:", otpCode)
         
        if defualtOTP == otpCode {
            print("success register")
        } else {
            print("not match")
        }
        
        // API call here
    }
}

