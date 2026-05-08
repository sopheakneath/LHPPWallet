//
//  OTPView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 23/3/26.
//

import SwiftUI
import Combine



//

struct OTPView: View {

    @State var phone: String = ""
    @StateObject private var viewModel = OTPViewModel()
   // var focusedIndex: Int?
    @State private var path: [OTPDestination] = []
    let source: OTPSource
    let otpCount = 6
    
    //
    
    @State private var focusedIndex: Int? = 0 // start focused on first
    

    
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
        case .login:
            return "/api/reset"
        }
    }
    func handleOTPVerified(for source: OTPSource) {
        path.append(source.nextDestination)
    }
    
    
    var body: some View {
        VStack {
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
//                HStack(spacing: 12) {
//                    ForEach(0..<otpCount, id: \.self) { index in
//                        OTPTextField(
//                            text: $viewModel.otp[index],
//                            isFocused: focusedIndex == index
//                        )
//                        
//                      //  .focused($focusedIndex, equals: index)
//                        .onChange(of: viewModel.otp[index]) { newValue in
//                            
//                            // Limit to 1 digit
//                            if newValue.count > 1 {
//                                viewModel.update(value: newValue, at: index)
//                                print(newValue)
//                            }
//                            
//                            // Move forward
////                            if newValue.count == 1 {
////                                if index < otpCount - 1 {
////                                    focusedIndex = index + 1
////                                } else {
////                                    focusedIndex = nil
////                                }
////                            }
//                        }
//                        .onChange(of: viewModel.otp[index]) { newValue in
//                            // Handle delete
//                            if newValue.isEmpty {
//                                if index > 0 {
//                                   // focusedIndex = index - 1
//                                }
//                            }
//                        }
//                    }
//                }
                
                HStack(spacing: 12) {
                    ForEach(0..<otpCount, id: \.self) { index in
                        OTPUITextField(
                            text: $viewModel.otp[index],
                            tag: index,
                            focusedIndex: $focusedIndex
                        )
                        .frame(width: 50, height: 55)
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
                    case .createPin:
                        CreatePinView(source: .login)
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

// new text field ---------------


struct OTPUITextField: UIViewRepresentable {
    @Binding var text: String
    var tag: Int
    @Binding var focusedIndex: Int?

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: OTPUITextField

        init(_ parent: OTPUITextField) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            // Keep only 1 character
            if let t = textField.text, t.count > 1 {
                textField.text = String(t.suffix(1))
            }
            parent.text = textField.text ?? ""

            // Move forward when 1 digit entered
            if (textField.text ?? "").count == 1 {
                parent.focusedIndex = parent.tag + 1
            }
        }

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Handle backspace to move backward
            if string.isEmpty, (textField.text ?? "").isEmpty {
                parent.focusedIndex = max((parent.tag - 1), 0)
            }
            return true
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    func makeUIView(context: Context) -> UITextField {
        let tf = UITextField()
        tf.keyboardType = .numberPad
        tf.textAlignment = .center
        tf.delegate = context.coordinator
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.backgroundColor = .white
        return tf
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text

        let isFocused = (focusedIndex == tag)
        uiView.layer.borderColor = (isFocused ? UIColor.systemBlue : UIColor.gray).cgColor

        if isFocused, !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
        } else if !isFocused, uiView.isFirstResponder {
            uiView.resignFirstResponder()
        }
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
                    .stroke(isFocused ? Color.blue : Color.gray, lineWidth: 1)
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
        OTPView(source: .register)
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


