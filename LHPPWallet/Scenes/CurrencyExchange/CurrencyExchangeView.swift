//
//  CurrencyExchangeView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 9/3/26.
//

import SwiftUI

struct CurrencyExchangeView: View {
    var body: some View {
        VStack(alignment: .leading) {
           
            VStack (alignment: .leading){
                Text("Current Exchange Rate")
                    .font(.maliMedium)
                Text("Last Updated : 30 May 2026 12:34:12")
                    .font(.maliRegular)
                Text("Rate are subject to change without prior notice")
                    .font(.custom("Mali-Regular", fixedSize: 12))
            }
            .padding(.leading, 20)
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
               // .padding(.top, 36)
            }
            Spacer()
        }
        .navigationTitle(
            Text("Exchange Rate")
                .font(.custom("Mali-Medium", fixedSize: 18))
        )
    }
}

#Preview {
    CurrencyExchangeView()
}
