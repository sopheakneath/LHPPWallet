//
//  ViewExtension.swift
//  LHPPWallet
//
//  Created by sopheakneath on 23/4/26.
//

import SwiftUI

    extension View {
        func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                            to: nil, from: nil, for: nil)
        }
    }

