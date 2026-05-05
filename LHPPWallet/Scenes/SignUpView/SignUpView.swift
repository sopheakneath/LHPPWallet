//
//  SignUpView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 23/3/26.
//

import SwiftUI

@available(iOS 15.0, *)
struct SignUpView: View {
    @State var phone: String = ""
    let source: OTPSource
    var body: some View {
        NavigationView {
            VStack {
                Image("signup-banner")
                
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity )
                    .padding(.top, 100)
                    .padding(.bottom, 30)
                    .padding(.horizontal,60)
                
                
                VStack(alignment: .leading) {
//                    Image("ic-kh-flag")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 33, height: 22)
//                    Text("+855")
//                    Text("|")
                   
                    
                    ValidatedTextField(title: "Country", placeHolder: "Country", text: $phone, validator: { input in
                       
                        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
                        if trimmed.isEmpty {
                            return "Phone require"
                        }
                        // Basic numeric and length check (adjust as needed)
                        let digits = trimmed.filter { $0.isNumber }
                        if digits.count < 8 { // simplistic minimum length
                            return "Invalid phone number"
                        }
                        return nil
                    })
                    
                  
                    ValidatedTextField(title: "phone number", placeHolder: "Phone Number", text: $phone, validator: { input in
                       
                        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
                        if trimmed.isEmpty {
                            return "Phone require"
                        }
                        // Basic numeric and length check (adjust as needed)
                        let digits = trimmed.filter { $0.isNumber }
                        if digits.count < 8 { // simplistic minimum length
                            return "Invalid phone number"
                        }
                        return nil
                    })
                  
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                
                Text("otp_decription".localized)
                    .padding(40)
                    
                   
                
                Spacer()
                NavigationLink {
                    if source.nextDestination == .createPin {
                        OTPView( source: .login)
                    } else {
                        OTPView( source: .register)
                    }
                 
                } label: {
                   
                        
                        Text("Next")
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, minHeight: 45)
                        
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.blue)
                            )
                            .padding(.horizontal, 20)
                    
                }
                .padding(.bottom,30)
               // .padding(.horizontal, 22)
                
//                Button {
//                    // viewModel.login()
//                    print("Login ")
//                } label: {
//                    Text("GET OTP")
//                        .foregroundColor(Color.white)
//                        .frame(maxWidth: .infinity, minHeight: 45)
//                    
//                        .background(
//                            RoundedRectangle(cornerRadius: 12)
//                                .fill(Color.blue)
//                        )
//                        .padding(.horizontal, 108)
//    
//                }
               
                
                
           // --------------------------------------------------------------------
                
                
                
                
//                Spacer()
//                ZStack{
//                    Image("camb")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: 80)
//                    Text("Ly Hour App")
//                }
                
                
            }
            .ignoresSafeArea()
        }
        .customBackToolbar(title: "Verify Phone Number")
    }
}

#Preview {
    if #available(iOS 15.0, *) {
        SignUpView( source: .login)
    } else {
        // Fallback on earlier versions
    }
}
