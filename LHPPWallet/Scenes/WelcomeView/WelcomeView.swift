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
    @StateObject var localization = LocalizationManager.shared
    
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
                        Text("slogan".localized)
                            .font(.MaliSemiBold)
                        
                        Text("discretion".localized)
                            .font(.maliMedium)
                    }
                    .padding(20)
                }
            }
            
            Spacer()
           
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
                    LoginView()
                } label: {
                    Text("login.loginButton".localized)
                        .font(.maliRegular)
                }
                
//                Button(action: {
//                    LoginView()
//                    print("i'm login")
//                }) {
//                    Text("login.loginButton".localized)
//                        .font(.maliRegular)
//                }
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


