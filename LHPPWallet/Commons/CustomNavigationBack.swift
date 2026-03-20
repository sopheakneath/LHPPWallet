//
//  CustomNavigationBack.swift
//  LHPPWallet
//
//  Created by sopheakneath on 20/3/26.
//
import SwiftUI

@available(iOS 15.0, *)
struct CustomBackToolbar: ViewModifier {
    let title: String
    
    @Environment(\.dismiss) private var dismiss
    @State private var didDismiss = false
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        guard !didDismiss else { return }
                        didDismiss = true
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.black)
                            
                            Text(title)
                                .foregroundColor(.black)
                                .font(.montserratMedium)
                        }
                    }
                    .disabled(didDismiss)
                }
            }
    }
}


