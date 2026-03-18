//
//  WelcomeView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 4/3/26.
//

import SwiftUI

@available(iOS 17.0, *)
struct WelcomeView: View {
    @State var gotoTerms: Bool = false
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack{
                    //  GeometryReader
                    Image("image_banner")
                        .resizable()
                        .scaledToFit()
                        .frame(width: .infinity, height: .infinity)
                    VStack {
                        Text("SIMPLIFYING PAYMENTS FOR A BETTER TOMORROW. . .")
                            .font(.custom("Mali", size: 20))
                        Text("An easy app to manager all payment to financial and related need")
                            .font(
                                .custom("Mali", size: 12))
                    }
                    .padding(20)
                }
            }
            
            Spacer()
            Button {
                gotoTerms = true
            } label: {
                Text("Get Started")
                    .foregroundStyle(Color.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 52)
            }
            .background(Color.red)
            .cornerRadius(8)
            // navigation link
            NavigationLink(destination: TermsConditionsView(), isActive: $gotoTerms) {}
            
            HStack {
                Text("You already have an account?" )
                    .foregroundStyle(Color.black)
                
                Button("Login") {
                    //
                }
            }
            .padding(.top,24)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("Menu tapped")
                    } label: {
                        Image("logo")
                            .resizable()
                            .frame(width: 56, height: 56)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Profile tapped")
                    } label: {
                        Image("ic_language")
                    }
                }
            }
        }
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        WelcomeView()
    } else {
        // Fallback on earlier versions
    }
}



