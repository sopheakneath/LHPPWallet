//
//  HomeHeader.swift
//  LHPPWallet
//
//  Created by sopheakneath on 31/3/26.
//

import SwiftUI

struct HomeHeader: View {
   @Binding var isShowbalance: Bool
    var versionApp: String = "3.2.2"
    var body: some View {
        VStack {
            HStack {
                VStack (alignment: .leading){
                    Text("Sopheakneath")
                        .font(.maliBold)
                    Text("\("app_version".localized) \(versionApp)")
                }
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
            
            Text(isShowbalance ? "Hide balance" : "Show balance")
                .font(.maliMedium)
                .foregroundColor(Color.white)
                .padding(10)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        isShowbalance.toggle()
                    }
                }

            if isShowbalance {
                
                
                HStack(spacing: 4) {
                    VStack(alignment: .leading) {
                        Text("USD") // currency
                            .font(.maliMedium)
                        Text("$75.79")  // balance
                            .font(.MaliSemiBold)
                        HStack {
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 12, height: 12)
                            Text("PRIMARY ACCOUNT")
                                .font(.maliRegular)
                        }
                        
                       
                    }
                  Spacer()
                    
                    Text("More Account")
                        .font(.maliRegular)
                    
                }
                .padding(.leading, 25)
                .padding(.trailing,45)
                .padding(.bottom,22)
                .foregroundColor(Color.white)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
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
