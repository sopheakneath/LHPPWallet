//
//  WalletListView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 10/4/26.
//

import SwiftUI

//transfer type => wallet
//wallet type => ... (identify wallet)

@available(iOS 15.0, *)
struct WalletListView: View {
    
    private let items: [TransferItem] = [
        TransferItem(image: "profile", title: "Lyhour"),
        TransferItem(image: "profile", title: "U Pay"),
        TransferItem(image: "number-9", title: "Pi Pay"),
        TransferItem(image: "profile", title: "E money")
    ]

    let bgColors = ["#D4DDFF", "#FFC7CE", "#FFFED4", "#D4E8FF", "#D4FCFF", "#FFE7D4"]
    
    
    var body: some View {
        VStack {
            Text("")
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                NavigationLink(destination: navigationview(idx: index)){
                    HStack {
                        Image(item.image)
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text(item.title)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                   
                    .background(Color(hex: bgColors.isEmpty ? "#FFFFFF" : bgColors[index % bgColors.count]))
                    .cornerRadius(8)
                    .padding(.horizontal,20)
                    .padding(.vertical,5)
                   // .padding(20)
                    
                    
                }
            }
           Spacer()
        }
        .customBackToolbar(title: "wallets".localized)
       
    }
        
}

@available(iOS 15.0, *)
private func navigationview(idx: Int) -> AnyView {
    switch idx {
    case 0:
        return AnyView(TransferFormView())
    default:
        return AnyView(WalletListView())
    }
}

#Preview {
    if #available(iOS 15.0, *) {
        WalletListView()
    } else {
        // Fallback on earlier versions
    }
}

