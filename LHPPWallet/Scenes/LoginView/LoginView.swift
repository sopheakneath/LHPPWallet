//
//  LoginView.swift
//  LHPPWallet
//
//  Created by Sopheakneath on 21/3/26.
//

import SwiftUI


struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isFocused: Bool = false
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image("profile")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .padding(.horizontal,65 )
            
            HStack {
                SecureField("Password", text: $password)
                    .padding(.vertical)
                Spacer(minLength: 10)
                Image(systemName: "person")
                    .foregroundColor(.blue)
                    .font(.title)
            }
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color(.white))
                    .shadow(color: Color.blue.opacity(0.1), radius: 20, x: -5, y: -5)
                    .shadow(color: Color.blue.opacity(0.1), radius: 20, x: 5, y: 5)
                    
            )
            .padding(.bottom,30)
        
            HStack {
                SecureField("Password", text: $password)
                    .padding(.vertical)
                Spacer(minLength: 10)
                Image(systemName: "lock")
                    .foregroundColor(.red)
                    .font(.title)
            }
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color(.white))
                    .shadow(color: Color.blue.opacity(0.1), radius: 20, x: -5, y: -5) // light top-left
                    .shadow(color: Color.blue.opacity(0.1), radius: 20, x: 5, y: 5)
            )
        
                        
            Spacer()
            Button {
                
            } label: {
                 Text("Login")
                    .background(Color.blue)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    LoginView()
}
