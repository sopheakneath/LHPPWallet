//
//  RegisterFormView.swift
//  LHPPWallet
//
//  Created by Sopheakneath on 28/3/26.
//

import SwiftUI


//@available(iOS 17.0, *)
//@available(iOS 17.0, *)

//@available(iOS 16.0, *)
@available(iOS 15.0, *)
struct RegisterFormView: View {
    @State var firsName: String = ""
    @State var lastName: String = ""
    @State var userName: String = ""
    @State var password: String = ""
    @State var dateOfBirth: String = ""
    @State var referCode: String = ""
    //@State var gender: String = ""
    @State private var isOn = false
    @State private var gender = "M"


    @State private var biometric = true
      @State private var notification = false
    
    
    var body: some View {
    NavigationView{
        
            VStack{
                
                Image("profile")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .cornerRadius(60)
                    .padding(.vertical, 28)
                
                HStack {
                    ValidatedTextField(title: "First Name", placeHolder: "", text: $firsName, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
                        .padding(.trailing, 10)
                    
                    
                    ValidatedTextField(title: "Last name", placeHolder: "", text: $lastName, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
                        .padding(.leading, 10)
                }
                ValidatedTextField(title: "User name", placeHolder: "", text: $userName, validator: { value in
                    if value.trimmingCharacters(in: .whitespacesAndNewlines).count < 7 {
                        return "user name is required"
                    }
                    return nil
                    
                }, keyboardType: .default, isSecure: false, isTitleFrame: false)
                ValidatedTextField(title: "password", placeHolder: "",
                                   text: $password,
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
                
            
                ValidatedTextField(title: "Date of birth", placeHolder: "", text: $dateOfBirth, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: true, isTitleFrame: false)
                ValidatedTextField(title: "Referral code", placeHolder: "", text: $referCode, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
               
                HStack(spacing: 0) {
                        genderButton(title: "Male", value: "M")
                        genderButton(title: "Female", value: "F")
                    }
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(30)
                    .padding(.horizontal, 30)
                    .onChange(of: gender, perform: {newValue in
                        print("hello \(newValue)")
                    },  )

                
                NavigationLink{
                    LoginView()
                }label: {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        
                        .font(.maliRegular)
                       
                        .foregroundColor(Color.white)
                       // .background(Color(hex:"#286CB3"))
                        .background(Color.primaryBlue)
                        .cornerRadius(30)
                        .padding(.horizontal, 90)
                       
                }
                .padding(.top, 50)
                
            }
            .padding(.horizontal, 14)
        }
    .customBackToolbar(title: "Account Registration")
      
    }
}
@available(iOS 15.0, *)
extension RegisterFormView {
    func genderButton(title: String, value: String) -> some View {
        Button(action: {
            gender = value
        }) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(gender == value ? Color.blue : Color.clear)
                .foregroundColor(gender == value ? .white : .black)
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

