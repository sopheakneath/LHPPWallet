//
//  RegisterFormView.swift
//  LHPPWallet
//
//  Created by Sopheakneath on 28/3/26.
//

import SwiftUI


//@available(iOS 17.0, *)
//@available(iOS 17.0, *)
struct RegisterFormView: View {
    @State var firsName: String = ""
    @State var lastName: String = ""
    @State var userName: String = ""
    @State var password: String = ""
    @State var dateOfBirth: String = ""
    @State var referCode: String = ""
    @State var gender: String = ""
    var body: some View {
    NavigationView{
            VStack{
                HStack {
                    ValidatedTextField(title: "First Name", placeHolder: "name", text: $firsName, validator: { value in value.isEmpty ? "Required" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
                    
                    ValidatedTextField(title: "Last name", placeHolder: "name", text: $lastName, validator: { value in value.isEmpty ? "Required" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
                }
                ValidatedTextField(title: "User name", placeHolder: "name", text: $userName, validator: { value in value.isEmpty ? "Required" : nil }, keyboardType: .default, isSecure: false, isTitleFrame: false)
                ValidatedTextField(title: "password", placeHolder: "Password", text: $password, validator: { value in value.isEmpty ? "Required" : nil }, keyboardType: .numberPad, isSecure: true, isTitleFrame: false)
                ValidatedTextField(title: "Date of birth", placeHolder: "Password", text: $dateOfBirth, validator: { value in value.isEmpty ? "Required" : nil }, keyboardType: .numberPad, isSecure: true, isTitleFrame: false)
                ValidatedTextField(title: "Referral code", placeHolder: "referral code", text: $referCode, validator: { value in value.isEmpty ? "Required" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
              
                Picker("Gender", selection: $gender) {
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                   
                        
                }
                .frame(maxHeight: 80)
                .pickerStyle(.segmented)
                .frame(maxHeight: 80)
                .cornerRadius(30)
                .padding(.horizontal, 30)
                .onChange(of: gender){  newValue in
                    print("value is \(newValue)")
                    
                }
                
                NavigationLink{
                    LoginView()
                }label: {
                    Text("go to login")
                        .padding(10)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(20)
                       
                }
                
            }
        }
      
    }
}



#Preview {
    if #available(iOS 17.0, *) {
        RegisterFormView()
    } else {
        // Fallback on earlier versions
    }
    
}

