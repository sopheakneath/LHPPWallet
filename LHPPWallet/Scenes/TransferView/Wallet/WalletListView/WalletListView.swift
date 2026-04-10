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
            Text("wallet list")
        }
        .customBackToolbar(title: "wallets".localized)
       
    }
        
}

#Preview {
    WalletListView()
}
