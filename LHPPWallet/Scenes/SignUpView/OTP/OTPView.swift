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
        NavigationView {
            VStack(alignment: .leading) {
                Image("otp-banner")
                
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity )
                    .padding(.top, 100)
                    .padding(.bottom, 30)
                    .padding(.horizontal,103)
                
                
                HStack {
                    Image("ic-kh-flag")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 33, height: 22)
                    Text("+855")
                    Text("|")
                    TextField("phone_number".localized, text: $phone)
                    
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                
                // OTP Verify
              
                    Text("enter_otp")
                    .padding(.leading, 20)

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

                NavigationLink{
                  //  LoginView()
                    RegisterFormView()
                }label: {
                    Text("VERIFY OTP ")
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, minHeight: 45)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(viewModel.isComplete ? Color.blue : Color.gray)
                        )
                        .padding(.horizontal, 108)
                }
                .padding(.top, 67)
                .disabled(!viewModel.isComplete)
                .padding(.horizontal,22)
                
                
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
        .customBackToolbar(title: "Mobile Number verification")
        
      
    }
        
}

// ===============================================

struct OTPTextField: View {
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
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isFocused ? Color.blue : Color.black, lineWidth: 1)
            )
    }
}


// ------------------------------------------------
#Preview {
    if #available(iOS 15.0, *) {
        OTPView()
    } else {
        // Fallback on earlier versions
    }
}



// ----------------------------------------------


private struct MockTransaction: Hashable {
    let id: String
    let timestamp: Date
   // let timestamp: String

    static let sampleData: [MockTransaction] = [
        // Feb 10, 2025
        MockTransaction(id: "tx-001", timestamp: makeDate(2025, 2, 10, 22, 23)),
        MockTransaction(id: "tx-002", timestamp: makeDate(2025, 2, 10, 23, 0)),
        MockTransaction(id: "tx-003", timestamp: makeDate(2025, 2, 10, 12, 0)),
        MockTransaction(id: "tx-004", timestamp: makeDate(2025, 2, 10, 10, 23)),
        // Same ID repeated in source data; dedupe keeps one.1
        MockTransaction(id: "tx-004", timestamp: makeDate(2025, 2, 10, 10, 23)),

        // Feb 9, 2025
        MockTransaction(id: "tx-005", timestamp: makeDate(2025, 2, 9, 9, 10)),
        MockTransaction(id: "tx-006", timestamp: makeDate(2025, 2, 9, 18, 42))
    ]
}

private func makeDate(_ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int) -> Date {
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    components.hour = hour
    components.minute = minute
    components.second = 0
    components.calendar = Calendar(identifier: .gregorian)
    return components.date ?? Date()
}


