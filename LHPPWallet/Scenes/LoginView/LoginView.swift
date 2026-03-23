//
//  LoginView.swift
//  LHPPWallet
//
//  Created by Sopheakneath on 21/3/26.
//

import SwiftUI


struct LoginView: View {
    
    @State private var isFocused: Bool = false
    @StateObject var viewModel = LoginViewModel()
    
    
    var body: some View {
       
        VStack(alignment: .center, spacing: 0) {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .padding(.horizontal,65 )
                .padding(.top, 8)
            
            HStack {
                TextField("Email", text: $viewModel.username)
                    .padding(.vertical)
                Spacer(minLength: 10)
                Image(systemName: "person")
                    .foregroundColor(.blue)
                    .font(.title)
            }
            .padding(.horizontal,20)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color(.white))
                    .shadow(color: Color.blue.opacity(0.1), radius: 20, x: -5, y: -5)
                    .shadow(color: Color.blue.opacity(0.1), radius: 20, x: 5, y: 5)
                    
            )
            .padding(.bottom,30)
            .padding(.horizontal, 20)
        
            HStack {
                SecureField("Password", text: $viewModel.password)
                    .padding(.vertical)
                Spacer(minLength: 10)
                Image(systemName: "lock")
                    .foregroundColor(.red)
                    .font(.title)
            }
            .padding(.horizontal,20)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color(.white))
                    .shadow(color: Color.blue.opacity(0.1), radius: 20, x: -5, y: -5) // light top-left
                    .shadow(color: Color.blue.opacity(0.1), radius: 20, x: 5, y: 5)
            )
            .padding(.horizontal, 20)
            
            HStack() {
                Spacer()
                Button{
                    // go to forget paw
                }label: {
                    Text("Forget password")
                        .padding(.top, 15)
                        .frame(alignment: .trailing)
                        .foregroundColor(Color.blue)
                        .padding(.trailing, 20)
                }
                
                
            }
            
            Button {
                viewModel.login()
                print("Login ")
            } label: {
                 Text("Login ")
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, minHeight: 45)
                   
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue)
                    )
                    .padding(.horizontal, 108)
                    
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 34)
            
            HStack {
                Button{
                    
                } label: {
                    VStack {
                        Image("face-id")
                            .scaledToFit()
                            .frame(width: 73,height: 60)
                        Text("Face ID")
                    }
                }
                .padding(.trailing, 74)
                
                Button{
                    
                } label: {
                    VStack{
                        Rectangle()
                            .cornerRadius(20)
                            .frame(width: 38, height: 60)
                            .foregroundColor(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.gray, lineWidth: 2)
                            
                            )
                        Text("PIN")
                    }
                    
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 14)
    
                        
            Spacer()
            Button{
                // GO TO SIGN UP
              // NavigationLink(destination: SignUpView(), label: "")
            } label: {
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.black)
                    Text("SIGN UP")
                }
            }
            
            Image("camb")
                .resizable()
                .scaledToFit()
                .frame(height: 73)
        }
        
        // .padding(.horizontal, 20)
        //.disabled(!viewModel.isValid)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        
        
        
           
        
    }
        
}

#Preview {
    LoginView()
}


