//
//  BlogOfSettingView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 5/3/26.
//

import SwiftUI



struct BlogOfSettingView: View {
    var items: Int = 2
    var text : String = "qw"
    var body: some View {
        
        VStack {
            ForEach(0..<items) { i in
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
                    
                    Text("Wallet verify")
                }
                .frame(maxWidth: .infinity, alignment: .init(horizontal: .leading, vertical: .center))
                .onTapGesture {
                    print("my item is \(i)")
                }
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




#Preview {
    BlogOfSettingView(items: 2)
}
