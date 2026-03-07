//
//  TermsConditionsView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 5/3/26.
//

import SwiftUI

struct TermsConditionsView: View {
    
    @State  private var message: String = "When idling resources are needed to test the results of your app's asynchronous work, you might find yourself having to use one of the When idling resources are needed to test the results of your app's asynchronous work, you might find yourself having to use one of the When idling resources are needed to test the results of your app's asynchronous work, you might find yourself having to use one of theWhen idling resources are needed to test the results of your app's asynchronous work, you might find yourself having to use one of theWhen idling resources are needed to test the results of your app's asynchronous work, you might find yourself having to use one of theWhen idling resources are needed to test the results of your app's asynchronous work, you might find yourself having to use one of theWhen idling resources are needed to test the results of your app's asynchronous work, you might find yourself having to use one of the"
    
    
    @State private var isGotoHomeTab: Bool = false
  
    var body: some View {
        VStack {
            TextEditor(text: $message)
                .frame(width: .infinity, height: .infinity)
                .padding(20)
                .disabled(true)
            Spacer()
            Button {
              /// navigation
                isGotoHomeTab = true
            } label: {
               Text("I agree")
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .cornerRadius(8)
            }
            .background(Color(.systemBlue)  )
            .padding(20)
            .cornerRadius(8)
            
            NavigationLink(destination: HomeTabView(), isActive: $isGotoHomeTab) {
                
            }
        }
        .navigationTitle("Term and Condition")
        .navigationBarTitleDisplayMode(.automatic)
       
    }
}

#Preview {
    TermsConditionsView()
}
