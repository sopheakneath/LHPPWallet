//
//  CustormKeyboard.swift
//  LHPPWallet
//
//  Created by sopheakneath on 4/5/26.
//


import SwiftUI

struct CustomKeyboardView: View {
    @Binding var text: String
    
    let keys = [
        ["1","2","3"],
        ["4","5","6"],
        ["7","8","9"],
        ["1","0","⌫"]
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(keys, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { key in
                        Button(action: {
                            handleKey(key)
                        }) {
                            Text(key)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                }
                .background(Color.red)
            }
        }
        .padding()
    }
    
    func handleKey(_ key: String) {
        if key == "⌫" {
            if !text.isEmpty {
                text.removeLast()
            }
        } else {
            text.append(key)
        }
    }
}
