//
//  WelcomeView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 4/3/26.
//

import SwiftUI
import UIKit
import Foundation

struct WelcomeView: View  {
    @State var gotoTerms: Bool = false
    @StateObject var localization = LocalizationManager.shared
    
    
//    func colorForBackground(color: UIColor) -> Color {
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.configureWithTransparentBackground()
//        appearance.backgroundColor = .clear
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        UINavigationBar.appearance().compactAppearance = appearance
//        return Color(color)
//    }

    
    var body : some View {
        NavigationView {
            VStack {
                VStack{
                    //  GeometryReader
                    Image("image_banner")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    VStack {
                        Text("slogan".localized)
                            .font(.MaliSemiBold)
                        
                        Text("discretion".localized)
                            .font(.maliMedium)
                    }
                    .padding(20)
                }
                Button {
                    gotoTerms = true
                } label: {
                    Text ("get_start".localized)
                    
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
                    Text("have_acc".localized)
                        .foregroundColor(.black)
                        .font(.maliRegular)
                    
                    
                    
                    NavigationLink {
                        //LoginView()
                        SignUpView(source: .login)
                    } label: {
                        Text("login.loginButton".localized)
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
                            localization.toggleLanguage()
                        } label: {
                            Text(localization.titleForLanguageButton())
                                .font(.maliRegular)
                            Image(localization.imageForLanguageButton())
                                .resizable()
                                .frame(width: 40,height: 40)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
           
            
        }
    }
}

#Preview {
    WelcomeView()
   
}


