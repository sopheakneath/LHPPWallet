//
//  TermsConditionsView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 5/3/26.
//

import SwiftUI

@available(iOS 15.0, *)

struct TermsConditionsView: View {

    @State  private var message: String = "When idling resources are needed to test the results of your app's asynchronous work, you might find yourself having to use one of the When idling resources are needed to test the results of your app's asynchronous work, you might find yourself having to use one of the When idling resources are needed to test the results of your app's asynchronous work, you might find yourself having to use one of theWhen idling resources are needed to test the results of your app's asynchronous work, you might find yourself having to use one of theWhen idling resources are needed to test the results of your app's asynchronous work, you might find yourself having to use one of theWhen idling resources are needed to test the results of your app's asynchronous work, you might find yourself having to use one of theWhen idling resources are needed to test the results of your app's asynchronous work, you might find yourself having to use one of theWhen idling resources are needed to test the results of your app's asynchronous work, you might find yourself having to use one of the"
    
    
    var data = "hello to say hi"
    
    @State private var isGotoHomeTab: Bool = false
    @State private var isChecked: Bool = false
    
    @available(iOS 15.0, *)
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                Text(message)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .font(.maliRegular)
            }
            Spacer()
            checkBox(isChecked: $isChecked)
            Button {
                isGotoHomeTab = true
            } label: {
                Text("btn_agree".localized)
                    .font(.custom("Mali-Medium", fixedSize: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(isChecked ? Color(.systemBlue) : Color.gray)
                    )
            }
            .disabled(!isChecked)
            .padding(20)
            if #available(iOS 16.0, *) {
//                NavigationLink(destination: HomeTabView(), isActive: $isGotoHomeTab) {
//                    EmptyView()
//                }
                
                NavigationLink(destination: SignUpView(), isActive: $isGotoHomeTab) {
                    EmptyView()
                }
                
            } else {
                // Fallback on earlier versions
            }
        }
        .customBackToolbar(title: "Privacy Policy")
    }
}

@ViewBuilder
func checkBox(isChecked: Binding<Bool>) -> some View {

    HStack(){
        RoundedRectangle(cornerRadius: 6)
            .stroke(Color.gray,lineWidth: 0.5)
            .frame(width: 25, height: 25)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(isChecked.wrappedValue ? Color.green : Color.white )
            )
            .overlay(
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(.system(size: 12))
                    .opacity(isChecked.wrappedValue ? 1 : 0)
            )
            .onTapGesture {
                isChecked.wrappedValue.toggle()
            }
        Text("term".localized)
            .foregroundColor(.red)
            .font(.custom("Mali-Medium", fixedSize: 12))
        
    }
//    .navigationBarBackButtonHidden(true)
//    .navigationTitle("Term")
    .padding(.leading,20)
}
#Preview {
    if #available(iOS 15.0, *) {
        TermsConditionsView()
    } else {
        // Fallback on earlier versions
    }
}

