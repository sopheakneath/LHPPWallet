//
//  SettingsView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 5/3/26.
//

import SwiftUI

@available(iOS 16.0, *)
struct SettingsView: View {

    
    var body: some View {
        NavigationStack{
            
            ScrollView {
                ProfileDetailView()
                BlogOfSettingView()
                BlogOfSettingView()
                BlogOfSettingView()
            }
            .padding(.bottom, 100)
            
        }
        
        
    }
}
    
    
    struct datas: Identifiable {
        var id: Int
        var title: String
    }
    
    #Preview {
        if #available(iOS 16.0, *) {
            SettingsView()
        } else {
            // Fallback on earlier versions
        }
    }
    

