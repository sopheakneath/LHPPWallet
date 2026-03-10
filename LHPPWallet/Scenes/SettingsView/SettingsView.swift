//
//  SettingsView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 5/3/26.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        
        ScrollView {
            ProfileDetailView()
            BlogOfSettingView()
            BlogOfSettingView()
            BlogOfSettingView()
            
        }
        .padding(.bottom, 100)
        
    }
}


struct datas: Identifiable {
    var id: Int
    var title: String
}

#Preview {
    SettingsView()
}
