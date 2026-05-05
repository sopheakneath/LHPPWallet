//
//  CreatePinView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 4/5/26.
//

import SwiftUI

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
    @FocusState private var focusedIndex: Int?
    @State private var path: [OTPDestination] = []
    let source: OTPSource
   
    let otpCount = 4
    
    
    
    
    
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
                
                
                
                
                // OTP Verify not a 111
                
                HStack(spacing: 12) {
                    ForEach(0..<otpCount, id: \.self) { index in
                        OTPTextField(
                            text: $viewModel.pin[index],
                            isFocused: focusedIndex == index
                        )
                        
                        .focused($focusedIndex, equals: index)
                        .onChange(of: viewModel.pin[index]) { newValue in
                            
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
                        .onChange(of: viewModel.pin[index]) { newValue in
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
                }
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
                              //  .fill(viewModel.isComplete ? Color.blue : Color.gray)
                        )
                        .padding(.horizontal, 108)
                }
                .padding(.top, 67)
                //.disabled(!viewModel.isComplete)
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

