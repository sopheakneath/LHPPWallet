//
//  BackToolbarExtension.swift
//  LHPPWallet
//
//  Created by sopheakneath on 20/3/26.
//
import SwiftUI

//@available(iOS 15.0, *)
extension View {
   
    
    
        func customBackToolbar(title: String) -> some View {
            self.modifier(CustomBackToolbar(title: title))
        }
    
  
}
