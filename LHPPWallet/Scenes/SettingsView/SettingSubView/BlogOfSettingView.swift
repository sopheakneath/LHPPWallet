//
//  BlogOfSettingView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 5/3/26.
//

import SwiftUI

@available(iOS 16.0, *)
struct BlogOfSettingView: View {
    var items: Int = 2
    var text : String = "qw"
    @State var goToMap: Bool = false
    @State var selectedIdx  = 0
    private let data = ["Map","Excange rate" ,"Term & Condition", "Wallet Info"]
    var body: some View {
        NavigationStack {
            
            VStack {
                ForEach(0..<data.count, id: \.self) { i in
                    HStack {
                        ZStack(alignment: .center) {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 40, height: 40)
                                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 0)
                            Image("ic_support")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        .padding(.horizontal, 12)
                        
                        Text(data[i])
                            .font(.maliRegular)
                    }
                    .frame(maxWidth: .infinity, alignment: .init(horizontal: .leading, vertical: .center))
                    .onTapGesture {
                        goToMap = true
                        selectedIdx = i
                        print(i)
                        
                    }
                    NavigationLink(
                        destination: destinationView(indxt: selectedIdx),
                        isActive: $goToMap,
                    )
                    { EmptyView() }
                    
                }
                
            }
            
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 0)
            
            .padding(.leading, 19)
            .padding(.trailing, 15)
            .padding(.bottom, 20)
            
        }
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
        BlogOfSettingView(items: 2)
    } else {
        // Fallback on earlier versions
    }
}

