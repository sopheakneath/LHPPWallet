//
//  SuccessView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 24/4/26.
//

import SwiftUI

struct SuccessView: View {
    var successTyp: OTPSource
    var body: some View {
        VStack {
            VStack {
                Spacer()
                Text(successTyp.successTitle)
                HStack {
                    VStack{
                        Text(successTyp.successTitle)
                    }
                    
                    .frame(maxWidth: 500, maxHeight: 500)
                    .background(Color.blue)
                    .cornerRadius(500)
                    .padding(.bottom,-300)
                    .padding(.leading,60)
                    
                  
                }
            }
           
            
        }
        .navigationBarBackButtonHidden()
        .onAppear(
            // do somthing
            
            
        )
        
       
      
    }
        
}

#Preview {
    SuccessView(successTyp: .transfer)
}
