//
//  CreatePinView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 4/5/26.
//

import SwiftUI
import LocalAuthentication

extension Int {
    func clamped(to range: Range<Int>) -> Int {
        if self < range.lowerBound { return range.lowerBound }
        if self >= range.upperBound { return range.upperBound - 1 }
        return self
    }
}

@available(iOS 15.0, *)
struct CreatePinView: View {
    
    @State var phone: String = ""
    @StateObject private var viewModel = OTPViewModel()
    @State private var path: [OTPDestination] = []
    let source: OTPSource
   
    let otpCount = 4
    @State private var isKeypadVisible: Bool = true
    
    private var currentIndex: Int {
        viewModel.pin.prefix(otpCount).firstIndex(where: { $0.isEmpty }) ?? otpCount
    }
    
    private var isPinComplete: Bool {
        !viewModel.pin.prefix(otpCount).contains(where: { $0.isEmpty })
    }
    
    private func appendDigit(_ digit: Int) {
        guard (0...9).contains(digit) else { return }
        guard currentIndex < otpCount else { return }
        viewModel.pin[currentIndex] = String(digit)
    }
    
    private func deleteLastDigit() {
        if let lastFilled = viewModel.pin.prefix(otpCount).lastIndex(where: { !$0.isEmpty }) {
            viewModel.pin[lastFilled] = ""
        }
    }
    
    private func authenticateBiometricsIfAvailable() {
        let context = LAContext()
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else { return }
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate to continue") { _, _ in
            // Intentionally no-op on Create PIN screen.
        }
    }
    
    
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Image("pin_key")
                
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity )
                    .padding(.top, 100)
                    .padding(.bottom, 30)
                    .padding(.horizontal,103)
                
                VStack {
                    Text("Create Login PIN")
                        .foregroundColor(Color.blue)
                    Text("A 4-digit pin can be create to have quick access to your Wallet. If you skip this step now you may still do it later.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 50)
                   
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                
                
                
                HStack(spacing: 12) {
                    ForEach(0..<otpCount, id: \.self) { index in
                        PinDigitBox(
                            isActive: index == min(currentIndex, otpCount - 1),
                            isFilled: !(viewModel.pin[index].isEmpty)
                        )
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.spring(response: 0.32, dampingFraction: 0.9)) {
                        isKeypadVisible = true
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 22)
                .frame(maxWidth: .infinity)
                
                
               
               

                NavigationLink{
                    
                //    LoginView()
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
                        LoginView()
                    }

                }label: {
                    Text("Done")
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, minHeight: 45)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(isPinComplete ? Color.blue : Color.gray)
                        )
                        .padding(.horizontal, 108)
                }
                .padding(.top, 67)
                .disabled(!isPinComplete)
                .padding(.horizontal,22)
                
                Spacer()
                
                if isKeypadVisible {
                    PinKeypad(
                        onDigit: appendDigit(_:),
                        onBiometrics: authenticateBiometricsIfAvailable,
                        onDelete: deleteLastDigit
                    )
                    .padding(.horizontal, 40)
                    .padding(.bottom, 10)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                
                ZStack{
                    Image("camb")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                    Text("Ly Hour App")
                        .font(.montserratMedium)
                }
                
            }
            
        }
        .onAppear {
            // show initially unless already complete
            isKeypadVisible = !isPinComplete
        }
        .onChange(of: isPinComplete) { complete in
            withAnimation(.spring(response: 0.32, dampingFraction: 0.9)) {
                isKeypadVisible = !complete
            }
        }
        .onTapGesture {
            // tap outside to hide (only if not complete)
            guard !isPinComplete else { return }
            withAnimation(.spring(response: 0.32, dampingFraction: 0.9)) {
                isKeypadVisible = false
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: LoginView()) {
                    Text("Skip")
                }

            }
        }
        .navigationBarBackButtonHidden(true)
       // .customBackToolbar(title: source.title)
        
       
    }
}

#Preview {
    if #available(iOS 15.0, *) {
        CreatePinView( source: .login)
    } else {
        // Fallback on earlier versions
    }
}

@available(iOS 15.0, *)
private struct PinDigitBox: View {
    let isActive: Bool
    let isFilled: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 52, height: 52)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isActive ? Color.blue : Color.gray.opacity(0.5), lineWidth: 1)
                )
            
            if isFilled {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 14, height: 14)
            }
        }
    }
}

@available(iOS 15.0, *)
private struct PinKeypad: View {
    let onDigit: (Int) -> Void
    let onBiometrics: () -> Void
    let onDelete: () -> Void
    
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 18), count: 3)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 18) {
            ForEach(1...9, id: \.self) { n in
                KeypadButton(title: "\(n)") { onDigit(n) }
            }
            
            KeypadIconButton(systemName: "touchid") { onBiometrics() }
            KeypadButton(title: "0") { onDigit(0) }
            KeypadIconButton(systemName: "delete.left") { onDelete() }
        }
    }
}

@available(iOS 15.0, *)
private struct KeypadButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, minHeight: 56)
        }
        .buttonStyle(KeypadButtonStyle())
    }
}

@available(iOS 15.0, *)
private struct KeypadIconButton: View {
    let systemName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, minHeight: 56)
        }
        .buttonStyle(KeypadButtonStyle())
    }
}

@available(iOS 15.0, *)
private struct KeypadButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.18), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(configuration.isPressed ? 0.06 : 0.10), radius: 10, x: 0, y: 6)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
    }
}

