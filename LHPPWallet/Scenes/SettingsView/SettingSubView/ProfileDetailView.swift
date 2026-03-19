//
//  ProfileDetailView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 5/3/26.
//

import SwiftUI

@available(iOS 16.0, *)
struct ProfileDetailView: View {
    var body: some View {
        ZStack (alignment: .center) {
            Image("bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Image("profile")
                    .resizable()
                    .frame(width: 82, height: 82)
                    .cornerRadius(41)
                Text ("jucy lala")
                    .font(.custom("Mali-Medium", fixedSize: 18))
                
                
                Text ("+855 968707219")
                    .font(.maliRegular)
                Text ("Lyhour Pay Pro plc")
                    .font(.maliRegular)
                
                HStack {
                    VStack {
                        Text ("70")
                            .foregroundStyle(Color.blue)
                            .font(.custom("Mali-Bold", fixedSize: 24))
                        
                        Text ("Loyal point")
                            .font(.maliRegular)
                    }
                    Spacer()
                    VStack {
                        Text ("Classic")
                            .foregroundStyle(Color.red)
                            .font(.custom("Mali-Bold", fixedSize: 24))
                        
                        
                        Text ("Wallet User type")
                            .font(.maliRegular)
                    }
                    Spacer()
                    VStack {
                        Text ("6w349k")
                            .foregroundStyle(Color.red)
                            .font(.maliRegular)
                        Text ("Refferal code")
                            .font(.maliRegular)
                    }
                    
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
            }
            
            
        }
        .padding(.bottom,23 )
    }
}

#Preview {
    if #available(iOS 16.0, *) {
        ProfileDetailView()
    } else {
        // Fallback on earlier versions
    }
}

