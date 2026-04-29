//
//  LoginView.swift
//  LHPPWallet
//
//  Created by Sopheakneath on 21/3/26.
//

import SwiftUI



//@available(iOS 16.0, *)
//@available(iOS 15.0, *)
@available(iOS 15.0, *)
struct LoginView: View {
    
    @State private var isFocused: Bool = false
    @StateObject var viewModel = LoginViewModel() // viewModel should expose an @Published var isLoggedIn: Bool used to drive navigation
   

    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .center, spacing: 0) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal,65 )
                    .padding(.top, 8)
                
                HStack {
                    TextField(("login.phoneOrUsername".localized), text: $viewModel.username)
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
                    SecureField(("login.password".localized), text: $viewModel.password)
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
                        Text("login.forgetPassword".localized)
                            .padding(.top, 15)
                            .frame(alignment: .trailing)
                            .foregroundColor(Color.blue)
                            .padding(.trailing, 20)
                    }
                }
                
                NavigationLink(destination: HomeTabView(), isActive: $viewModel.isLoggedIn) {
                    EmptyView()
                }
                .hidden()
                .onChange(of: viewModel.isSuccess) { newValue in
                    if newValue {
                        print("success123")
                    }
                }
               
                Button {
                   // viewModel.login()
                    Task {
                        await viewModel.loginSe()
                    }
                } label: {
                    Text("login.loginButton".localized)
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
                .onAppear {
                    Task {
                        await viewModel.loginTestSecurity()
                    }
                }
                
                Text(viewModel.alertMessage ?? "error message not found")
                    .foregroundColor(Color.red)
            
                HStack {
                    Button{
                        
                    } label: {
                        VStack {
                            Image("face-id")
                                .scaledToFit()
                                .frame(width: 73,height: 60)
                            Text("login.faceId".localized)
                        }
                    }
                    .padding(.trailing, 74)
                    
                    Button{
                        
                    } label: {
                        VStack{
                            ZStack{
                                Rectangle( )
                                .cornerRadius(20)
                                .frame(width: 38, height: 60)
                                .foregroundColor(Color.clear)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.gray, lineWidth: 2)
                                )
                                Text("***")
                                    .foregroundColor(Color.black)
                            }
                            
                            Text("login.pin".localized)
                        }
                        
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 14)
              
                
                Spacer()
                NavigationLink {
                    SignUpView()
                } label: {
                    HStack {
                        Text("login.noAccount".localized)
                            .foregroundColor(.black)
                        Text("login.signUp".localized)
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.top, 8)

                
                Image("camb")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 73)
            }
            
            .ignoresSafeArea()
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        localization.toggleLanguage()
//                    } label: {
//                        Text(localization.titleForLanguageButton())
//                            .font(.maliRegular)
//                    }
                }
            }
            .alert(viewModel.alertMessage ?? "", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            }
        }
       
       
    }
}
// 100 0.001 x 400 
#Preview {
    if #available(iOS 16.0, *) {
        LoginView()
    } else {
        // Fallback on earlier versions
    }
}


