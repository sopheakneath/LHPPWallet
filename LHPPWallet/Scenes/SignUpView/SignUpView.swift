//
//  SignUpView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 23/3/26.
//

import SwiftUI

struct SignUpView: View {
    @State var phone: String = ""
    var body: some View {
        NavigationView {
            VStack {
                Image("signup-banner")
                
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity )
                    .padding(.top, 24)
                    .padding(.bottom, 30)
                    .padding(.horizontal,60)
                
                
                HStack {
                    Image("ic-kh-flag")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 33, height: 22)
                    Text("+855")
                    Text("|")
                    TextField("Phone Number", text: $phone)
                        .keyboardType(.phonePad)
                        .onTapGesture {
                            print(" on tap gesture")
                        }
                    //  .firstReserved
                    
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                
                // Replace the Button around "SIGN UP" with:
                NavigationLink {
                    
                    if #available(iOS 15.0, *) {
                        OTPView()
                    } else {
                        // Fallback on earlier versions
                    }
                } label: {
                    HStack {
                        
                        Text("GET OTP")
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.top, 8)
                
                Button {
                    // viewModel.login()
                    print("Login ")
                } label: {
                    Text("GET OTP")
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, minHeight: 45)
                    
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue)
                        )
                        .padding(.horizontal, 108)
    
                }
                .padding(.top,67)
                .padding(.horizontal, 22)
                Spacer()
                ZStack{
                    Image("camb")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                    Text("Ly Hour App")
                }
                
                
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    SignUpView()
}
