//
//  TransferFormView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 22/4/26.
//

import SwiftUI


@available(iOS 15.0, *)
struct TransferFormView: View {
    
    @Binding var amount: String
    @Binding var inputRemark: String
    
    @State var isAddRemark: Bool = false
    @State private var goToOTP = false
    @StateObject var keyboard = KeyboardResponder()
    
    
    init(amount: Binding<String> = .constant(""), inputRemark: Binding<String> = .constant("")) {
        self._amount = amount
        self._inputRemark = inputRemark
    }
    
    var body: some View {
   
        ZStack {
            // Hidden NavigationLink for programmatic navigation
            NavigationLink(destination: OTPView(source: .transfer), isActive: $goToOTP) { EmptyView() }

            VStack(alignment: .leading) {
                
                Text("From")
                HStack {
                    Image("ic_language_kh")
                        .resizable()
                        .frame(width: 60, height: 60)
                    VStack(alignment: .leading){
                        Text("KHR") // CURRENTCY
                        Text("XXXX908342") // ACC NUMBER
                        Text("0968707219") // ACC NAME
                    }
                    
                    Spacer()
                    Image("drop_down")
                        .resizable()
                        .frame(width: 20, height: 10)
                }
                .padding()
               // .background(Color.lightBlue)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(
                    color: Color.black.opacity(0.2),
                    radius: 3
                )
                
                
                Image("downarrow")
                    .frame(maxWidth: .infinity, alignment: .center)
                
                
                
                Text("To")
                HStack {
                    Image("ic_language_kh")
                        .resizable()
                        .frame(width: 60, height: 60)
                    VStack(alignment: .leading){
                        Text("KHR") // CURRENTCY
                        Text("XXXX908342") // ACC NUMBER
                        Text("0968707219") // ACC NAME
                    }
                    
                    Spacer()
                    Image("contract_book")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("|")
                    Text("USD")
                    
                    Image("drop_down")
                        .resizable()
                        .frame(width: 20, height: 10)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(
                    color: Color.black.opacity(0.2),
                    radius: 3
                )
                
                
                Text("Amount")
                TextField("Input Amount", text: $amount)
                    .multilineTextAlignment(.center)
                    .font(.MaliSemiBold)
                    .padding(.top, 5)
                    .padding(.bottom, 50)

                VStack {
                    Button {
                        isAddRemark.toggle()
                    } label: {
                        Text("Add remark" )
                            .font(.maliRegular)
                            .padding(10)
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .cornerRadius(4)
                            .shadow(
                                color: Color.black.opacity(0.2),
                                radius: 3
                            )
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                if isAddRemark {
                    TextField("Add your remark here...", text: $inputRemark)
                      
                        .padding()
                      //  .multilineTextAlignment(.leading)
                        .foregroundColor(Color.black)
                        .background(Color.lightGray)
                        .padding()
                        .minimumScaleFactor(0.5)
                       // .onAppear { self.inputRemark = "" }
                        .lineLimit(2)
                       
                }
                
                Spacer()
                
                Button {
                    // Trigger navigation to OTP screen
                    goToOTP = true
                } label: {
                    Text("Cornfirm")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(8)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                    
                        .cornerRadius(10)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .padding(.bottom, keyboard.height) // 🔥 key line
            .animation(.easeOut(duration: 0.25), value: keyboard.height)
           // .hideKeyboard()
            
        }
    }
        
    
       
       
       
        
    
}





#Preview {
    if #available(iOS 15.0, *) {
        TransferFormView(amount: .constant(""), inputRemark:.constant(""))
    } else {
        // Fallback on earlier versions
    }
}

