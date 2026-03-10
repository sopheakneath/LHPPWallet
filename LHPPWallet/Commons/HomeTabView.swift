//
//  HomeTabView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 5/3/26.
//

import SwiftUI
struct HomeTabView: View {
    @State private var selectedTab = 0
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Main content (no TabView = no system tab bar)
            Group {
                switch selectedTab {
                case 0: MapView()
                case 2: CurrencyExchangeView() // Placeholder for middle tab
                case 3: Color.clear
                case 4: SettingsView()
                default: Color.clear
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
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

struct TabBarButton: View {
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .frame(width: 48, height: 48)
                    .tint(isSelected ? Color.gray : Color.blue  )
                
                Image(icon)
                    .font(.system(size: 24))
                    .symbolRenderingMode(.hierarchical)
                // .foregroundColor(isSelected ? .red : .green)
                    .frame(maxWidth: .infinity)
            }
            
            
        }
    }
}

#Preview {
    HomeTabView()
}

