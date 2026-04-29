//
//  StoreImageView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 29/4/26.
//

import SwiftUI

struct StoreImageView: View {
   
    var body: some View {
        HStack{
            HStack{
                Image("card")
                    .resizable()
                    .frame(width: 45, height: 30)
                Text("Profile.png")
            }
            
            Spacer()
            
            HStack{
                Image("eye")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .padding(10)
                    .background(Color.lightPurple)
                    .cornerRadius(18)
                    .padding(.trailing, 5)
                Image("delete")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .padding(10)
                    .background(Color.lightRed)
                    .cornerRadius(18)
               
                
                
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical,8)
        .background(Color.white)
        .shadow(radius: 1)
        .padding()
        .cornerRadius(8)
        
    }
}

#Preview {
    StoreImageView()
}
