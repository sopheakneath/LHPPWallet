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
    
//    init() {
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = .red
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        UINavigationBar.appearance().compactAppearance = appearance
//    }
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack{
                    //  GeometryReader
                    Image("image_banner")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    VStack {
                        Text("SIMPLIFYING PAYMENTS FOR A BETTER TOMORROW. . .")
                            .font(.MaliSemiBold)
                        
                        Text("An easy app to manager all payment to financial and related need")
                            .font(.maliMedium)
                    }
                    .padding(20)
                }
            }
            
            Spacer()
            Button {
                gotoTerms = true
            } label: {
                Text("Get Started")
                    .font(.system(size: 16, weight: .semibold))
                    .font(.custom("Mali-Medium", fixedSize: 16))
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 52)
            }
            .background(Color.red)
            .cornerRadius(8)
            // navigation link
            NavigationLink(destination: TermsConditionsView(), isActive: $gotoTerms) {}
            
            HStack {
                Text("You already have an account?" )
                    .foregroundColor(.black)
                    .font(.maliRegular)
                
                Button(action: {
                    //
                }) {
                    Text("LOGIN")
                        .font(.maliRegular)
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
                    .buttonStyle(.plain)
                    .background(Color.clear)
                   
                }
    
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Profile tapped")
                    } label: {
                        Image("ic_language_kh")
                    }
                    .buttonStyle(.plain)
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            
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


