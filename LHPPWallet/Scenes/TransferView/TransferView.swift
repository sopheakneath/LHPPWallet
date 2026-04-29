//
//  TransferView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 9/4/26.
//

import SwiftUI

// init transfer type

struct TransferItem: Identifiable {
    let id = UUID()
    let image: String
    let title: String
}

@available(iOS 15.0, *)
struct TransferView: View {
    
    
    
    private let items: [TransferItem] = [
        TransferItem(image: "profile", title: "Wallet"),
        TransferItem(image: "profile", title: "Bank/MFI"),
        TransferItem(image: "number-9", title: "9Digit-code"),
        TransferItem(image: "profile", title: "Card")
    ]

    let bgColors = ["#D4DDFF", "#FFC7CE", "#FFFED4", "#D4E8FF", "#D4FCFF", "#FFE7D4"]
    
    
    @StateObject var viewModel = TransferViewModel()
    
    
  
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                NavigationLink(destination: navigationview(idx: index)){
                    HStack(spacing: 8) {
                        // Replace with your image logic when available
                        Image(item.image)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                            .background(Color(hex: bgColors.isEmpty ? "#FFFFFF" : bgColors[index % bgColors.count]))
                            .cornerRadius(8)
                        Text(item.title)
                            .font(.maliMedium)
                        
                    }
                }
              //   transfer screen => validation => stransfer success
                .padding()
               
                .frame(maxWidth: .infinity, alignment: .leading)
                //.background(Color.blue)
                //.shadow(color: Color.red, radius: 3)
                .cornerRadius(12)
               // .shadow(color: Color.red, radius: 5)
               
                //.contentShape(Rectangle())
               
               
            }
            Spacer()
        }
    
        .padding()
        .customBackToolbar(title: "transfer".localized)
        .task {
            await viewModel.fetchWalletList()
            print("wallet list \(viewModel.item.count)")
        }
       
    }
       
}
 
@available(iOS 15.0, *)
@ViewBuilder
private func navigationview(idx: Int)-> some View {
    switch idx {
    case 0 :
        return WalletListView()
    default:
        return WalletListView()
    }
}

#Preview {
    if #available(iOS 15.0, *) {
        TransferView()
    } else {
        // Fallback on earlier versions
    }
}

