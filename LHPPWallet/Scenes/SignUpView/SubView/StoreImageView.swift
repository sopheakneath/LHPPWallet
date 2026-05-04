//
//  StoreImageView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 29/4/26.
//

import SwiftUI

struct StoreImageView: View {
    let title: String
    let onPreview: () -> Void
    let onDelete: () -> Void
   
    var body: some View {
        HStack{
            HStack{
                Image("card")
                    .resizable()
                    .frame(width: 45, height: 30)
                Text(title)
            }
            
            Spacer()
            
            HStack{
                Button(action: onPreview) {
                    Image("eye")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .padding(10)
                        .background(Color.lightPurple)
                        .cornerRadius(18)
                }
                .padding(.trailing, 5)
                Button(action: onDelete) {
                    Image("delete")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .padding(10)
                        .background(Color.lightRed)
                        .cornerRadius(18)
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical,8)
        .background(Color.white)
  //      .shadow(radius: 1)
//        .padding(1)
//        .cornerRadius(8)
        .overlay(
               RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 0.5)
           )
        
    }
}

#Preview {
    StoreImageView(title: "Profile.png", onPreview: {}, onDelete: {})
}
