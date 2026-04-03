//
//  TransferList.swift
//  LHPPWallet
//
//  Created by sopheakneath on 1/4/26.
//

import SwiftUI

struct TransferList: View {
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 160), spacing: 16)
    ]
    let imageGroup = ["profile", "wing","aba","bill","loan", "ppshv"]
    let titles = ["Add money","Transfer","Top up", "Build Payment", "Loan Payment", "PPSHV"]
    let bgColor = ["#D4DDFF", "#FFC7CE", "#FFFED4", "#D4E8FF","#D4FCFF", "#FFE7D4" ]
    
    let items: [Int]
    
    init(items: [Int]) {
        self.items = items
    }
    // can id to reusable at anoter screen
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(items, id: \.self) { item in
                    if item - 1 < imageGroup.count && item - 1 < titles.count && item - 1 < bgColor.count {
                        CellTransfer(number: item, image: imageGroup[item - 1], title: titles[item - 1], colors: bgColor[item - 1])
                            .padding(8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(.white))
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: -5, y: -5) // light top-left
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                            )
                            .onTapGesture {
                                print("hello on tap\(item)")
                            }
                    }
                }
                .padding(6)
            }
           // .padding(25)
        }
    }
}
// --------------------------

struct CellTransfer: View {
    let number: Int
    let image: String
    let title: String
    let colors: String
    
    var body: some View {
        HStack(spacing: 8) {
           Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
            VStack(alignment: .leading, spacing: 2) {
                Text("Sopheakneath")
                    .font(.system(size: 10))
                   
                    //.lineLimit(1)
                   
                Text("0968707219")
                    .font(.system(size: 10))
                  //  .lineLimit(1)
            }
            Spacer()
            Text("$")
                .font(.maliBold)
               
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .contentShape(Rectangle())
        
    }
}

#Preview {
    TransferList(items: Array(1...6))
}

