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
           
            VStack (alignment: .leading){
                Text("Current Exchange Rate")
                    .font(Font.title.bold())
                Text("Last Updated : 30 May 2026 12:34:12")
                Text("Rate are subject to change without prior notice")
            }
            if #available(iOS 15.0, *) {
                ItemSubView()
                    .padding(.top, 36)
            } else {
                // Fallback content for iOS versions earlier than 15.0
                Group {
                    if #available(iOS 15.0, *) {
                        Text("Exchange items are not available on this iOS version.")
                            .foregroundColor(.secondary)
                    } else {
                        Text("Exchange items are not available on this iOS version.")
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.top, 36)
            }
            Spacer()
        }
        .navigationTitle(
            Text("Exchange Rate")
        )
    }
}

#Preview {
    CurrencyExchangeView()
}
