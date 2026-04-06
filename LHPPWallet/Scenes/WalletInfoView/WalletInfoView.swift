//
//  WalletInfoView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 16/3/26.
//

import SwiftUI

//@available(iOS 17.0, *)
@available(iOS 15.0, *)
struct WalletInfoView: View {
    // User info
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var name: String = ""
    @State private var mail: String = ""
    @State private var password: String = ""
    
    //address info
    
    @State private var province: String = ""
    @State private var District: String = ""
    @State private var commune: String = ""
    @State private var village: String = ""
    @State private var country: String = ""
    @State private var Address: String = ""
    @State private var Address1 : String = ""
    @State private var occupation : String = ""
    
    
  
    @State private var navigateToHome: Bool = false
    
    
    @State private var saveMessage: String? = nil
    @State private var showingSaveAlert: Bool = false

    @State private var nameError: String? = nil
    @State private var passwordError: String? = nil
    
    //
    @StateObject var viewModel = WalletInfoViewModel()
    

    var body: some View {
        
        NavigationView {
            VStack {
                NavigationLink(destination: HomeTabView(), isActive: $viewModel.submitted) {EmptyView()}
                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 0)
                    .hidden()
                Form {
                    Section(header: Text("Personal Information")
                        .foregroundColor(Color.black)
                        .font(.maliMedium)) {
                            VStack {
                                ValidatedTextField(
                                    title: "First Name", placeHolder: "",
                                    text: $viewModel.firstName,
                                    validator: { value in
                                        if viewModel.firstName.isEmpty {
                                            return "First name can't be empty"
                                        }
                                        return nil
                                    },
                                    isSubmit: viewModel.showMessage
                                    
                                )
                                
                                ValidatedTextField(
                                    title: "Last name", placeHolder: "",
                                    text: $viewModel.lastName,
                                    validator: { value in
                                        if viewModel.lastName.isEmpty {
                                            return "Last name can't be empty"
                                        }
                                        return nil
                                    },
                                    keyboardType: .default,
                                    isSubmit: viewModel.showMessage
                                    // isSecure: true
                                )
                                
                                ValidatedTextField(
                                    title: "Prefer Name",
                                    placeHolder: "",
                                    text: $viewModel.name,
                                    validator: { value in
                                        if viewModel.name.isEmpty {
                                            return "User name can't be empty"
                                        }
                                    return nil
                                },
                                    isSubmit: viewModel.showMessage
                                )
                                
                                ValidatedTextField(
                                    title: "Email(optional)", placeHolder: "",
                                    text: $mail,
                                    validator: { value in
                                        return nil
                                    }
                                )
                            }
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 0)
                            )
                        }
                    
                    Section(header: Text("Address Info")
                        .font(.maliMedium)
                        .foregroundColor(Color.black)
                    ) {
                        VStack {
                            ValidatedTextField(
                                title: "Provinc", placeHolder: "",
                                text: $province,
                                validator: { value in
                                    if value.isEmpty {
                                        viewModel.errorMessage = "error province"
                                    }
                                    return nil
                                }
                            )
                            
                            ValidatedTextField(
                                title: "District", placeHolder: "",
                                text: $District,
                                validator: { value in
                                    return nil
                                },
                                keyboardType: .default,
                                isSecure: false
                            )
                            
                            ValidatedTextField(
                                title: "Commune", placeHolder: "",
                                text: $commune,
                                validator: { value in
                                    return nil
                                }
                            )
                            
                            ValidatedTextField(
                                title: "Village", placeHolder: "",
                                text: $village,
                                validator: { value in
                                    return nil
                                }
                            )
                            ValidatedTextField(
                                title: "Address", placeHolder: "",
                                text: $Address,
                                validator: { value in
                                    return nil
                                }
                            )
                            ValidatedTextField(
                                title: "Address 1", placeHolder: "",
                                text: $Address1,
                                validator: { value in
                                    return nil
                                }
                            )
                            ValidatedTextField(
                                title: "Occupation", placeHolder: "",
                                text: $occupation,
                                validator: { value in
                                    return nil
                                }
                            )
                        }
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 0)
                        )
                    }
                    
                }
                .background(Color.white)
                .onAppear {
                    if let savedName = UserDefaults.standard.string(forKey: "wallet.name") {
                        name = savedName
                    }
                    if let savedPassword = UserDefaults.standard.string(forKey: "wallet.password") {
                        password = savedPassword
                    }
                }
                
                .background(Color.white.ignoresSafeArea())
                
                Button {
                    print("Action button")
                    viewModel.saveInfo()
                    navigateToHome = true
                } label: {
                    
                    Text("Done")
                        .font(.maliRegular)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(Color.blue)
                }
                .cornerRadius(8)
                .padding()
            }
        }
        .customBackToolbar(title: "wallet info")
    }
       
      
    private var isFormValid: Bool {
        let nameValid = name.trimmingCharacters(in: .whitespacesAndNewlines).count >= 3
        let passwordValid: Bool = {
            let trimmed = password.trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmed.count >= 6 && trimmed.rangeOfCharacter(from: .decimalDigits) != nil
        }()
        return nameValid && passwordValid
    }
}


   

#Preview {
    if #available(iOS 17.0, *) {
        WalletInfoView()
    } else {
        // Fallback on earlier versions
    }
}


