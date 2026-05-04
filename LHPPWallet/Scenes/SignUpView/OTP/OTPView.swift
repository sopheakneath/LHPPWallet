//
//  OTPView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 23/3/26.
//

import SwiftUI
import Combine

@available(iOS 15.0, *)

//

struct OTPView: View {
    
    
    
    @State var phone: String = ""
    @StateObject private var viewModel = OTPViewModel()
    @FocusState private var focusedIndex: Int?
    @State private var path: [OTPDestination] = []
    let source: OTPSource
   
    let otpCount = 6
    
    
    @State private var timeRemaining = 60 // seconds
    @State private var timer: Timer? = nil

    
    //
    var NavigationtoSucess: String {
        switch source {
        case .register:
            return "/api/register/otp"
        case .transfer:
            return "/api/transfer/confirm"
        case .resetPassword:
            return "/api/reset"
        }
    }
    func handleOTPVerified(for source: OTPSource) {
        path.append(source.nextDestination)
    }
    
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
                
                VStack {
                    Text("verify_code".localized)
                    Text("Please type the verification code sent to")
                    Text("+855 xxx xx x19")
                        .foregroundColor(Color.blue)
                        .font(.maliMedium)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                
                
                
                // OTP Verify not a 111
                VStack {
                    Text("Re-send code in")
                        .padding(.leading, 20)
                    
                    HStack {
                        Text("\(timeRemaining)")
                            .foregroundColor(.red)
                           // .padding(.leading, 20)
                        Text("sec")
                            //.padding(.leading, 20)
                    }
                   
                }
                .frame(maxWidth: .infinity, alignment: .center)
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
                .onAppear {
                    focusedIndex = 0
                    startTimer()
                    
                }

                NavigationLink{
                    switch source.nextDestination {
                    case .registrationSuccess:
                        RegisterFormView()
                    case .registrationFlow:
                        RegisterFormView()
                    case .transferSuccess:
                      
                        SuccessView(successTyp: .transfer)
                    case .resetPasswordFlow:
                        TransferView()
                    }

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
        .customBackToolbar(title: source.title)
    }
    
    
    func startTimer() {
            stopTimer() // prevent multiple timers
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    stopTimer()
                }
            }
        }
    func stopTimer() {
         //timeRemaining = 60
            timer?.invalidate()
            timer = nil
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


private func Hdeader(idx: Int) -> String {
    switch idx {
    case 0:
        return "txt"
    default:
        return ""
    }
}





// ------------------------------------------------
#Preview {
    if #available(iOS 15.0, *) {
        OTPView(source: .register)
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


