//
//  BackToolbarExtension.swift
//  LHPPWallet
//
//  Created by sopheakneath on 20/3/26.
//
import SwiftUI

extension View {
        func customBackToolbar(title: String) -> some View {
            self.modifier(CustomBackToolbar(title: title))
        }
    
  
}
