//
//  BannerView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 1/4/26.
//



//

import SwiftUI
import Combine
//import Combine

struct BannerView: View {
    let images = ["logo", "aba", "wing"]

    @State private var currentIndex = 0

    // Timer for auto scroll
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(0..<images.count, id: \.self) { index in
                VStack {
                    Image(images[index])
                        .resizable()
                        .scaledToFill()
                        .tag(index)
//
               //
                        .cornerRadius(30)
                        .padding(.horizontal, 30)
                      
                }

            }
           
        }
      
        //.background(Color.blue)
        .frame(height: 200)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))

        .onReceive(timer) { data in
            withAnimation {
                currentIndex = (currentIndex + 1) % images.count
            }
        }
    }
}

#Preview {
    BannerView()
}
