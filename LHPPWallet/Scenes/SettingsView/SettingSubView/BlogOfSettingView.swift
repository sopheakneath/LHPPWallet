//
//  BlogOfSettingView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 5/3/26.
//

import SwiftUI

@available(iOS 16.0, *)
struct BlogOfSettingView: View {
    private let data = ["Map","Excange rate" ,"Term & Condition", "Wallet Info"]
    var body: some View {
        VStack {
            ForEach(0..<data.count, id: \.self) { i in
                NavigationLink(destination: destinationView(indxt: i)) {
                    HStack {
                        ZStack(alignment: .center) {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 38, height: 39)
                                .shadow(
                                    color: Color(red: 226/255, green: 233/255, blue: 255/255).opacity(1),
                                    radius: 2, x: 0, y: 0
                                )
                            // #E2E9FF
                            Image("ic_support")
                                .resizable()
                                .frame(width: 19, height: 22)
                        }
                        .padding(.horizontal, 12)
                        Text(data[i])
                            .font(.maliRegular)
                    }
                    .padding(.vertical, 8)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .init(horizontal: .leading, vertical: .center)
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 0)
        .padding(.leading, 19)
        .padding(.trailing, 15)
        .padding(.bottom, 20)
    }
}

@available(iOS 15.0, *)
@ViewBuilder
func destinationView (indxt : Int) -> some View {
    switch indxt {
    case 0:
        MapView()
    case 1:
        CurrencyExchangeView()
    case 2:
        TermsConditionsView()
    case 3:
        if #available(iOS 17.0, *) {
            WalletInfoView()
        } else {
            // Fallback on earlier versions
        }
        
    default:
        Text("Unknown")
    }
    
}


#Preview {
    if #available(iOS 16.0, *) {
        BlogOfSettingView()
    } else {
        // Fallback on earlier versions
    }
}

