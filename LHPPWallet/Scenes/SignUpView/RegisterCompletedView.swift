//
//  RegisterCompletedView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 4/5/26.
//

import SwiftUI

@available(iOS 15.0, *)
struct RegisterCompletedView: View {
    var body: some View {
        VStack{
            Image("relax")
                .resizable()
                .frame(maxHeight: 280)
                .padding(.horizontal, 80)
                .padding(.vertical, 80)
            Text("Your profile already submit and review")
                .font(.MaliSemiBold)
                .padding(.horizontal, 53)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
              
            Text("We are proccessing your document. You might get a call from us for further verification.")
                .font(.maliRegular)
                .foregroundColor(Color.gray)
                .padding(.horizontal, 53)
                .multilineTextAlignment(.center)
            Spacer()
            NavigationLink{
                LoginView()
            }label: {
                Text("Done")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    
                    .font(.maliRegular)
                   
                    .foregroundColor(Color.white)
                   // .background(Color(hex:"#286CB3"))
                    .background(Color.primaryBlue)
                    .cornerRadius(8)
                    .padding(.horizontal,20)
            }
        }
        .navigationBarBackButtonHidden(true)
       
    }
}

#Preview {
    if #available(iOS 15.0, *) {
        RegisterCompletedView()
    } else {
        // Fallback on earlier versions
    }
}
