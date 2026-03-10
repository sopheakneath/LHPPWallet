//
//  CurrencyExchangeView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 9/3/26.
//

import SwiftUI

struct CurrencyExchangeView: View {
    var body: some View {
        VStack() {
            Text("Current Exchange Rate")
                .font(Font.title.bold())
            Text("Last Updated : 30 May 2026 12:34:12")
            Text("Rate are subject to change without prior notice")
            ItemSubView()
                .padding(.top,36)
        Spacer()
        }
        .padding(.leading,20)
    
    }
}

#Preview {
    CurrencyExchangeView()
}
