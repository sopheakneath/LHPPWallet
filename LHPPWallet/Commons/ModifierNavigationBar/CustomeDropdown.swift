//
//  CustomeDropdown.swift
//  LHPPWallet
//
//  Created by sopheakneath on 11/5/26.
//

import Foundation
import SwiftUI

struct DropdownItem: Identifiable, Hashable {
    
    let id = UUID()
    let title: String
}

struct CustomDropdown: View {
    
    let title: String
    let placeholder: String
    let items: [DropdownItem]
    
    @Binding var selectedItem: DropdownItem?
    
    @State private var isExpanded = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            Text(title)
                .font(.headline)
            
            Button(action: {
                
                withAnimation {
                    isExpanded.toggle()
                }
                
            }) {
                
                HStack {
                    
                    Text(selectedItem?.title ?? placeholder)
                        .foregroundColor(
                            selectedItem == nil
                            ? .gray
                            : .black
                        )
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .rotationEffect(
                            .degrees(isExpanded ? 180 : 0)
                        )
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
            }
            
            if isExpanded {
                
                VStack(spacing: 0) {
                    
                    ForEach(items) { item in
                        
                        Button(action: {
                            
                            selectedItem = item
                            
                            withAnimation {
                                isExpanded = false
                            }
                            
                        }) {
                            
                            HStack {
                                
                                Text(item.title)
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                if selectedItem == item {
                                    
                                    Image(systemName: "checkmark")
                                }
                            }
                            .padding()
                        }
                        
                        Divider()
                    }
                }
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 4)
            }
        }
    }
}


