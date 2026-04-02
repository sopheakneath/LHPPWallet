//
//  HomeHeader.swift
//  LHPPWallet
//
//  Created by sopheakneath on 31/3/26.
//

import SwiftUI

struct HomeHeader: View {
   @Binding var isShowbalance: Bool
    var body: some View {
        VStack {
            HStack {
                Text("Sopheakneath")
                    .font(.maliBold)
                Spacer()
                Image("profile")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
            }
            
            .padding(.horizontal,20)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(
                Color.white
                    .clipShape(
                        RoundedCorner(
                            radius: 60,
                            corners: [.bottomRight]
                        )
                    )
            )
           
//                    .overlay(
//                        Rectangle().stroke(Color.green, lineWidth: 5)
//                            .cornerRadius(60)
//                            .background(
//                                Color.clear
//                                    .clipShape(
//                                        CustomCorner(
//
//                                            bottomRight: 200
//                                        )
//                                    )
//                            )
//                       // Circle().stroke(Color.green, lineWidth: 5)
//                    )
          
            // -----------------------------------
            
            
            
            if isShowbalance {
                //
            } else {
                
            }
            
            Text("Show balance")
                .padding(10)
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    self.isShowbalance = true
                    print("Show UI")
                }
           if isShowbalance {
//                Text("$400")
//               Text("Saving Account")
            }
            // stop here first i need to
            
        }
        .background(
            Color.red
                .clipShape(
                    CustomCorner(
                        bottomLeft : 60,
                        bottomRight: 200
                    )
                )
        )
    }
}

#Preview {
    HomeHeader(isShowbalance: .constant(true))
}
