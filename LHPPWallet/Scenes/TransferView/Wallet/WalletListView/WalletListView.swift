//
//  WalletListView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 10/4/26.
//

import SwiftUI

struct WalletListView: View {
    var body: some View {
        VStack {
            HStack {
                Image("logo")
                    .resizable()
                    .frame(width: 40, height: 40)
                Text("Pi Pay")
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.softPurple)
            .cornerRadius(8)
            .padding(20)
           
           
        }
        .customBackToolbar(title: "wallets".localized)
       
    }
        
}

#Preview {
    WalletListView()
}
