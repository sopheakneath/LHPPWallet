//
//  ItemSubView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 9/3/26.
//

import SwiftUI

@available(iOS 15.0, *)
struct ItemSubView: View {
    var body: some View {
        ForEach (0..<4) { i in
            HStack {
                HStack {
                    Image ("ic_language_us")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .scaledToFit()
                    Image ("ic_language_kh")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .scaledToFit()
                        .padding(.leading, -15)
                }
                VStack (alignment: .leading){
                    Text("USD / KH").font(.maliMedium)
                    Text("US Dollar / Cambodian Riel").font(.maliRegular)
                        .font(.custom("Mali-Regular", fixedSize: 12))
                        .foregroundStyle(Color.gray)
                }
                Spacer()
                VStack (alignment: .trailing){
                    Text("4,000 / 4,100").font(.maliMedium)
                    Text("Buy / Sell")
                        .font(.custom("Mali-Regular", fixedSize: 12))
                        .foregroundStyle(Color.gray)
                }
            }
        }
        .padding(.horizontal,20)
    }
}

#Preview {
    if #available(iOS 15.0, *) {
        ItemSubView()
    } else {
        // Fallback on earlier versions
    }
}
