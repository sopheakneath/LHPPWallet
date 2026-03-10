//
//  ProfileDetailView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 5/3/26.
//

import SwiftUI

struct ProfileDetailView: View {
    var body: some View {
        ZStack (alignment: .center) {
            //            Color(.systemBackground)
            //                .edgesIgnoringSafeArea(.all)
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
                
                Text ("+855 968707219")
                Text ("Lyhour Pay Pro plc")
                
                HStack {
                    VStack {
                        Text ("70")
                            .foregroundStyle(Color.blue)
                            .fontWidth(.expanded)
                        Text ("Loyal point")
                    }
                    Spacer()
                    VStack {
                        Text ("Classic")
                            .foregroundStyle(Color.red)
                            .fontWidth(.init(600))
                        
                        
                        Text ("Wallet User type")
                    }
                    Spacer()
                    VStack {
                        Text ("6w349k")
                            .foregroundStyle(Color.red)
                            .fontWidth(.init(600))
                        Text ("Refferal code")
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
    ProfileDetailView()
}

