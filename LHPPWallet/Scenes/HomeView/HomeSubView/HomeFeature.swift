//
//  HomeFeature.swift
//  LHPPWallet
//
//  Created by sopheakneath on 31/3/26.
//

import SwiftUI

@available(iOS 15.0, *)
struct HomeFeature: View {
    
    let columns = [
        GridItem(.adaptive(minimum: 100), spacing: 16)
    ]
    let imageGroup = ["wallet_outlin", "transfer","phone_topup","bill","loan", "ppshv"]
    let titles = ["Add money","Transfer","Top up", "Build Payment", "Loan Payment", "PPSHV"]
    let bgColor = ["#D4DDFF", "#FFC7CE", "#FFFED4", "#D4E8FF","#D4FCFF", "#FFE7D4" ]
    
    
    let items = Array(1...6)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(items, id: \.self) { item in
                    ItemCell(number: item, image: imageGroup[item - 1], title: titles[item - 1], colors: bgColor[item - 1])
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.white))
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: -5, y: -5) // light top-left
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                        )
                        .onSubmit {
                            print("hello on submit")
                        }
                        .onTapGesture {
                            print("hello on tap\(item)")
                        }
                }
                .padding(6)
            }
            .padding(25)
        }
    }
}

struct ItemCell: View {
    let number: Int
    let image: String
    let title: String
    let colors: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            VStack(alignment: .center) {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 27, height: 27)
                    .cornerRadius(8)
                    .padding(10)
            }
            .frame(maxWidth: .infinity)
            .padding(8)
            .background(Color(hex: colors))
            .cornerRadius(8)

            Text(title)
                .padding(.horizontal, -20)
                .font(.system(size: 10))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(10)
    }
}




// ----------------------------------------------


#Preview {
    if #available(iOS 15.0, *) {
        HomeFeature()
    } else {
        // Fallback on earlier versions
    }
}
