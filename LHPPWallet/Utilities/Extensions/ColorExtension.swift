//
//  ColorExtension.swift
//  LHPPWallet
//
//  Created by sopheakneath on 30/3/26.
//


import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.replacingOccurrences(of: "#", with: "")
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let r = Double((int >> 16) & 0xFF) / 255.0
        let g = Double((int >> 8) & 0xFF) / 255.0
        let b = Double(int & 0xFF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}

extension Color {
    static let primaryBlue = Color(hex: "#2074D7")
    static let lightBlue = Color(hex: "#B3D3F8")
    static let darkBlue = Color(hex: "#2C6AB4")
    static let vividBlue = Color(hex: "#3D70FF")
    
    static let backgroundGray = Color(hex: "#857F7F")
    static let lightGray = Color(hex: "##EAEAEA")
   
    static let softPurple = Color(hex: "#E9E1FF")
    
    static let success = Color(hex: "#2CB431")
    static let softGreen = Color(hex: "#59D793")
    static let prettyGreen = Color(hex: "#346739")
    static let lightPurple = Color(hex: "#DBE4FF")
    static let lightRed = Color(hex: "#FFE4E4")
}


