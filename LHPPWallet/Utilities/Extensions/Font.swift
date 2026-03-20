//
//  Font.swift
//  LHPPWallet
//
//  Created by sopheakneath on 19/3/26.
//
import SwiftUI

extension Font {
    internal var uiFont : UIFont {return UIFont.systemFont(ofSize: 20, weight: .medium) }
}

//extension Font {
//    internal var uiFont: UIFont {
//        return UIFont(name: "Mali-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14)
//    }
//}


extension Font {
    static let maliRegular = Font.custom("Mali-Regular", size: 14)
    static let maliMedium = Font.custom("Mali-Medium", size: 16)
    static let maliBold = Font.custom("Mali-Bold", size: 14)
    static let MaliSemiBold = Font.custom("Mali-SemiBold", size: 20)
    
    static let montserratRegular = Font.custom("Montserrat-Regular", size: 14)
    static let montserratMedium = Font.custom("Montserrat-Medium", size: 18)
    
  
}
