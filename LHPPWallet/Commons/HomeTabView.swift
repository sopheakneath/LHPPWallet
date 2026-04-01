//
//  HomeTabView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 5/3/26.
//

import SwiftUI
//@available(iOS 16.0, *)
struct HomeTabView: View {
    @State private var selectedTab = 0
   
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Main content (no TabView = no system tab bar)
            if #available(iOS 17.0, *) {
                Group {
                    switch selectedTab {
                    case 0: HomeView()
                    case 1: TransactionListView()
                    case 2: Color.clear
                    case 3: SettingsView()
                    case 4: SettingsView()
                    default: Color.clear
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            HStack {
                TabBarButton(icon: "home", isSelected: selectedTab == 0) {
                    selectedTab = 0
                }
                TabBarButton(icon: "quick", isSelected: selectedTab == 1) {
                    selectedTab = 1
                }
                // Custom middle button
                Button(action: {
                    selectedTab = 2
                }) {
                    ZStack {
                        
                        Circle()
                            .fill(Color.red)
                            .frame(width: 62, height: 62)
                            .shadow(radius: 4)
                        //                            .overlay(Circle().stroke(Color.green, lineWidth: 5))
                        
                        Image("ic_mobile_top_up")
                            .font(.system(size: 42, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 33.38, height: 33.38)
                    }
                    .offset(y: -31)
                }
                .offset(y: 0) // Raise it above the tab bar
                
                TabBarButton(icon: "menue", isSelected: selectedTab == 3) {
                    selectedTab = 3
                }
                
                TabBarButton(icon: "Vector", isSelected: selectedTab == 4) {
                    selectedTab = 4
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.blue)
                    .shadow(radius: 0)
                    .ignoresSafeArea()
            )
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationBarBackButtonHidden(true)
        
    }
}

//@available(iOS 16.0, *)
struct TabBarButton: View {
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .frame(width: 48, height: 48)
                    .foregroundColor(isSelected ? Color.gray : Color.blue)
                
                Image(icon)
                    .font(.system(size: 24))
                    //.symbolRenderingMode(.hierarchical)
                    .frame(maxWidth: .infinity)
            }
            
            
        }
    }
}

#if canImport(SwiftUI)
#Preview {
  
        HomeTabView()
   
}
#endif // canImport(SwiftUI)

