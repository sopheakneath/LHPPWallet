//
//  RegisterFormView.swift
//  LHPPWallet
//
//  Created by Sopheakneath on 28/3/26.
//

import SwiftUI

@available(iOS 15.0, *)
struct RegisterFormView: View {
    @StateObject private var viewModel = RegistrationViewModel()
    
    
    var body: some View {
    
    NavigationView{
        ScrollView {
                HStack{
                    VStack{
                        Text("1")
                            .frame(width: 40,height: 40)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(20)
                        Text("Fill Form")
                    }
                   
                  
                   
                    Rectangle()
                        .frame(width: 100)
                            .frame(height: 1)
                            .foregroundColor(.red)
                            .padding(.bottom,30)
                            .padding(.trailing, -40)
                    
                           
                    
                    VStack {
                        Text("2")
                            .frame(width: 40,height: 40)
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .cornerRadius(20)
                        Text("Update Document")
                    }
                    
                }
                
             
                    ValidatedTextField(title: "First Name", placeHolder: "First Name", text: $viewModel.firstName, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
                    
                    ValidatedTextField(title: "Last name", placeHolder: "Last Name", text: $viewModel.lastName, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
                      
                
                ValidatedTextField(title: "User name", placeHolder: "User Name", text: $viewModel.userName, validator: { value in
                    if value.trimmingCharacters(in: .whitespacesAndNewlines).count < 7 {
                        return "user name is required"
                    }
                    return nil
                    
                }, keyboardType: .default, isSecure: false, isTitleFrame: false)
                ValidatedTextField(title: "password", placeHolder: "Password",
                                   text: $viewModel.password,
                                   validator: { value in
                                       if value.trimmingCharacters(in: .whitespacesAndNewlines).count < 4 {
                                           return "Password most be at leasr 8 charater"
                                       }
                                       return nil
                                   },
                                   
                                   keyboardType: .numberPad,
                                   isSecure: true,
                                   isTitleFrame: false
                                   
                )
            ValidatedTextField(title: "Nick Name", placeHolder: "Nick Name", text: $viewModel.preferredName, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: true, isTitleFrame: false)
            ValidatedTextField(title: "Date of birth", placeHolder: "Date of birtd", text: $viewModel.dateOfBirth, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: true, isTitleFrame: false)
            ValidatedTextField(title: "Emain", placeHolder: "Email adress (optional)", text: $viewModel.email, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
            ValidatedTextField(title: "Province", placeHolder: "Province", text: $viewModel.province, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
            ValidatedTextField(title: "District", placeHolder: "District", text: $viewModel.district, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
            ValidatedTextField(title: "Commune (Optional)", placeHolder: "Commune (Optional)", text: $viewModel.commune, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
            ValidatedTextField(title: "Village (Optional)", placeHolder: "Village (Optional)", text: $viewModel.village, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
            ValidatedTextField(title: "Country", placeHolder: "Country", text: $viewModel.country, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
            
            ValidatedTextField(title: "Address", placeHolder: "Address", text: $viewModel.address1, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
            
            ValidatedTextField(title: "Address 2 (Optional)", placeHolder: "Address 2 (Optional)", text: $viewModel.address2, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
            
            ValidatedTextField(title: "Address 3 (Optional)", placeHolder: "Address 3 (Optional)", text: $viewModel.address3, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
            ValidatedTextField(title: "Gender", placeHolder: "Gender", text: $viewModel.gender, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
            ValidatedTextField(title: "Occupation", placeHolder: "Occupation", text: $viewModel.occupation, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
//
//
//                HStack(spacing: 0) {
//                        genderButton(title: "Male", value: "M")
//                        genderButton(title: "Female", value: "F")
//                    }
//                    .background(Color.gray.opacity(0.2))
//                    .cornerRadius(30)
//                    .padding(.horizontal, 30)
//                    .onChange(of: gender, perform: {newValue in
//                        print("hello \(newValue)")
//                    },  )

                
                NavigationLink{
                   // LoginView()
                    DocumentForm()
                        .environmentObject(viewModel)
                }label: {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        
                        .font(.maliRegular)
                       
                        .foregroundColor(Color.white)
                       // .background(Color(hex:"#286CB3"))
                        .background(Color.primaryBlue)
                        .cornerRadius(8)
                       // .padding(.horizontal, 90)
                       
                }
               // .frame(maxWidth: .infinity)
               // .padding(.top, 50)
                
            }
            
            .padding(.horizontal, 14)
            .background(Color.brightGray)
        }
    .customBackToolbar(title: "Account Registration")
   
      
    }
}

@available(iOS 15.0, *)
extension RegisterFormView {
    func genderButton(title: String, value: String) -> some View {
        Button(action: {
            viewModel.gender = value
        }) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(viewModel.gender == value ? Color.blue : Color.clear)
                .foregroundColor(viewModel.gender == value ? .white : .black)
                .cornerRadius(30)
        }
    }
}


#Preview {
   
    if #available(iOS 16.0, *) {
        RegisterFormView()
    } else {
        // Fallback on earlier versions
    }
   
    
}

