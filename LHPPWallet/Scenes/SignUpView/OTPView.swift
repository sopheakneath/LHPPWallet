//
//  OTPView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 23/3/26.
//

import SwiftUI
import Combine

@available(iOS 15.0, *)
struct OTPView: View {
    
    @State var phone: String = ""
    @StateObject private var viewModel = OTPViewModel()
    @FocusState private var focusedIndex: Int?
    
    let otpCount = 6
    
    var body: some View {
        VStack {
           Image("otp-banner")
               
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity )
                .padding(.top, 24)
                .padding(.bottom, 30)
                .padding(.horizontal,103)
                
            
            HStack {
                Image("ic-kh-flag")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 33, height: 22)
                Text("+855")
                Text("|")
                TextField("Phone Number", text: $phone)
                
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            
            // OTP Verify
            
            Text("Enter your OTP code")
   
        
        HStack(spacing: 12) {
            ForEach(0..<otpCount, id: \.self) { index in
                OTPTextField(
                    text: $viewModel.otp[index],
                    isFocused: focusedIndex == index
                )
                .focused($focusedIndex, equals: index)
                .onChange(of: viewModel.otp[index]) { newValue in
                    
                    // Limit to 1 digit
                    if newValue.count > 1 {
                        viewModel.update(value: newValue, at: index)
                        print(newValue)
                    }
                    
                    // Move forward
                    if newValue.count == 1 {
                        if index < otpCount - 1 {
                            focusedIndex = index + 1
                        } else {
                            focusedIndex = nil
                        }
                    }
                }
                .onChange(of: viewModel.otp[index]) { newValue in
                    // Handle delete
                    if newValue.isEmpty {
                        if index > 0 {
                            focusedIndex = index - 1
                        }
                    }
                }
            }
        }
            .padding()
            .onAppear {focusedIndex = 0}

        Button {
            viewModel.verifyOTP()
        } label: {
            Text("VERIFY OTP ")
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, minHeight: 45)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(viewModel.isComplete ? Color.blue : Color.gray)
                    )
                .padding(.horizontal, 108)
                    
            }
            .padding(.top,67)
            .disabled(!viewModel.isComplete)
            .padding(.horizontal, 22)
            
            
            Spacer()
            ZStack{
                Image("camb")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                Text("Ly Hour App")
                    .font(.montserratMedium)
            }
           
            
        }
    .ignoresSafeArea()
    }
}









// ===============================================



struct OTPTextField: View {
    
    
    //
    //    @State var phone: String = ""
    //
    //    var body: some View {
    //        VStack {
    //           Image("otp-banner")
    //
    //                .resizable()
    //                .scaledToFit()
    //                .frame(maxWidth: .infinity )
    //                .padding(.top, 24)
    //                .padding(.bottom, 30)
    //                .padding(.horizontal,103)
    //
    //
    //            HStack {
    //                Image("ic-kh-flag")
    //                    .resizable()
    //                    .scaledToFit()
    //                    .frame(width: 33, height: 22)
    //                Text("+855")
    //                Text("|")
    //                TextField("Phone Number", text: $phone)
    //
    //            }
    //            .padding(.leading, 20)
    //            .padding(.trailing, 20)
    //
    //            // OTP Verify
    //
    //            Text("Enter your OTP code")
    //
    //            Button {
    //               // viewModel.login()
    //                print("VERIFY OTP")
    //            } label: {
    //                 Text("VERIFY OTP ")
    //                    .foregroundColor(Color.white)
    //                    .frame(maxWidth: .infinity, minHeight: 45)
    //
    //                    .background(
    //                        RoundedRectangle(cornerRadius: 12)
    //                            .fill(Color.blue)
    //                    )
    //                    .padding(.horizontal, 108)
    //
    //            }
    //            .padding(.top,67)
    //
    //
    //            .padding(.horizontal, 22)
    //            Spacer()
    //            ZStack{
    //                Image("camb")
    //                    .resizable()
    //                    .scaledToFit()
    //                    .frame(height: 80)
    //                Text("Ly Hour App")
    //            }
    //
    //
    //        }
    //    .ignoresSafeArea()
    //    }
    //}
    //
    //@ViewBuilder
    //func OTPInput() ->  some View {
    //
    //}
    //
    //
    //extension OTPView {
    //
    //}

    
    ///////////
    
    @Binding var text: String
    var isFocused: Bool
    
    var body: some View {
        
        SecureField("", text: $text)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .frame(width: 50, height: 55)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.white))
//                    .shadow(color: Color.white.opacity(0.8), radius: 5, x: -3, y: -3)
//                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 3, y: 3)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isFocused ? Color.blue : Color.black, lineWidth: 1)
            )
    }
}

// AI UI --------------------------------------
//@available(iOS 15.0, *)
//struct OTPView: View {
//    
//    @StateObject private var viewModel = OTPViewModel()
//    @FocusState private var focusedIndex: Int?
//    
//    let otpCount = 6
//    
//    var body: some View {
//        VStack(spacing: 30) {
//            
//            Text("Enter OTP")
//                .font(.title2)
//                .bold()
//            
//            HStack(spacing: 12) {
//                ForEach(0..<otpCount, id: \.self) { index in
//                    OTPTextField(
//                        text: $viewModel.otp[index],
//                        isFocused: focusedIndex == index
//                    )
//                    .focused($focusedIndex, equals: index)
//                    .onChange(of: viewModel.otp[index]) { newValue in
//                        
//                        // Limit to 1 digit
//                        if newValue.count > 1 {
//                            viewModel.update(value: newValue, at: index)
//                            print(newValue)
//                        }
//                        
//                        // Move forward
//                        if newValue.count == 1 {
//                            if index < otpCount - 1 {
//                                focusedIndex = index + 1
//                            } else {
//                                focusedIndex = nil
//                            }
//                        }
//                    }
//                    .onChange(of: viewModel.otp[index]) { newValue in
//                        // Handle delete
//                        if newValue.isEmpty {
//                            if index > 0 {
//                                focusedIndex = index - 1
//                            }
//                        }
//                    }
//                }
//            }
//            
//            Button(action: {
//                viewModel.verifyOTP()
//            }) {
//                Text("Verify")
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(viewModel.isComplete ? Color.blue : Color.gray)
//                    .foregroundColor(.white)
//                    .cornerRadius(12)
//            }
//            .disabled(!viewModel.isComplete)
//            .padding(.horizontal)
//            
//        }
//        .padding()
//        .background(Color(.systemGray6).ignoresSafeArea())
//        .onAppear {
//            focusedIndex = 0
//        }
//    }
//}




// ------------------------------------------------
#Preview {
    if #available(iOS 15.0, *) {
        OTPView()
    } else {
        // Fallback on earlier versions
    }
}

