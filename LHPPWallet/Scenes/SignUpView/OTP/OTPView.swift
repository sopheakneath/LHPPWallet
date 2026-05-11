//
//  OTPView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 23/3/26.
//

import SwiftUI
import Combine


struct OTPView: View {

    @State var phone: String = ""
    @StateObject private var viewModel = OTPViewModel()
    @State private var navigate = false
    @State private var timeRemaining = 60 // seconds
    @State private var timer: Timer? = nil

    let source: OTPSource
    
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
                VStack {
                    Text("Re-send code in")
                        .padding(.leading, 20)
                    
                    HStack {
                        Text("\(timeRemaining)")
                            .foregroundColor(.red)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                ZStack(alignment: .center) {
                    OTPCodeTextField(text: $viewModel.otpCode)
                        .frame(width: 0, height: 0)
                        .opacity(0.01)

                    HStack(spacing: 12) {

                        ForEach(0..<6, id: \.self) { index in

                            ZStack {

                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white)
                                    .frame(width: 50, height: 55)

                                Text(getDigit(at: index))
                                    .font(.system(size: 24, weight: .semibold))

                            }
                           
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke( currentInputIndex() == index ? Color.blue : Color.lightGray, lineWidth: 1)
                            )
                            .onAppear() {
                                print("index: \(index)")
                                stopTimer()
                            }
                            .onDisappear() {
                                stopTimer()
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
              //  .padding()
                .onChange(of: viewModel.isComplete) { isComplete in
                    if isComplete {
                        navigate = true
                    }
                }
                
                NavigationLink(isActive: $navigate) {
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
                } label: {
                    EmptyView()
                }
                
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
    
   
        
}
// function
extension OTPView {
    private func currentInputIndex() -> Int {
        let count = min(viewModel.otpCode.count, 6)
        return count
    }
    
    func getDigit(at index: Int) -> String {

        if index < viewModel.otpCode.count {

            let array = Array(viewModel.otpCode)
            return String(array[index])
        }

        return ""
    }
    
    func startTimer() {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                   
                }
            }
        }
    func stopTimer() {
         //timeRemaining = 60
            timer?.invalidate()
            timer = nil
        }
}



// textField customize

struct OTPCodeTextField: UIViewRepresentable {

    @Binding var text: String
    @State var isFirstResponder: Bool = false


    class Coordinator: NSObject, UITextFieldDelegate {

        var parent: OTPCodeTextField

        init(parent: OTPCodeTextField) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {

            let value = textField.text ?? ""
            let filtered = value.filter { $0.isNumber }
            parent.text = String(filtered.prefix(6))

            textField.text = parent.text
           
            print("Parent \(parent.text)")
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UITextField {

        let textField = UITextField()

        textField.delegate = context.coordinator
        textField.keyboardType = .numberPad
        textField.textContentType = .oneTimeCode

        // Auto focus
        DispatchQueue.main.async {
            textField.becomeFirstResponder()
            isFirstResponder = true
        }
        if isFirstResponder {
            print("Become first responder")
        }
        
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
        if !uiView.isFirstResponder, isFirstResponder {
            uiView.becomeFirstResponder()
           // uiView.backgroundColor = .red
        }
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




