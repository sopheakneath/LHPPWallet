//
//  TestingDropdown.swift
//  LHPPWallet
//
//  Created by sopheakneath on 12/5/26.
//

import Foundation
import SwiftUI


struct DataList:  Identifiable , Hashable, Codable{
    let id = UUID()
    let title: String
}

struct CustomDropdownView: View {
    @State private var isExpanded = false
    @State private var selectedItem = "Select Country"
    @State private var searchText = ""
    @State private var dropdownPosition: CGFloat = 100

  //  @Binding var selectedItem: String
  
    
   
    let data : [DataList]
    let items = [
        "Cambodia",
        "Thailand",
        "Vietnam",
        "Singapore",
        "Malaysia",
        "Indonesia",
        "Japan",
        "Korea",
        "China",
        "Cambodia",
        "Thailand",
        "Vietnam",
        "Singapore",
        "Malaysia",
        "Indonesia",
        "Japan",
        "Korea",
        "China",
        "Cambodia",
        "Thailand",
        "Vietnam",
        "Singapore",
        "Malaysia",
        "Indonesia",
        "Japan",
        "Korea",
        "China",
    ]
    

    
    var filteredItems: [String] {
        if searchText.isEmpty {
            return data.map { $0.title }
        } else {
//            return items.filter {
//                $0.localizedCaseInsensitiveContains(searchText)
//            }
            
            return data.map { $0.title }.filter {
                $0.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
       // Spacer()
        
        ZStack(alignment: .center){
            
            // Dropdown Header
            Button {
                withAnimation {
                    isExpanded.toggle()
                }
            } label: {
                
                HStack {
                    Text(selectedItem)
                        .foregroundColor(
                            selectedItem == "Select Country"
                            ? .gray
                            : .black
                        )
                    
                    Spacer()
                    
                    Image(systemName: isExpanded
                          ? "chevron.up"
                          : "chevron.down")
                }
                .padding(8)
                .background(Color.white)
                
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3))
                )
            }
            
            // Dropdown List
           
            if isExpanded {
                ZStack{
                LazyVStack(spacing: 0) {
                    
                    // Search Field
                    TextField("Search...", text: $searchText)
                        .padding(12)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding()
                  
                    Divider()
                   
                    // Scrollable List
                    ScrollView() {
                        
                        VStack(spacing: 0) {
                            
                            
                            ForEach(filteredItems, id: \.self) { item in
                                
                                Button {
                                    selectedItem = item
                                    
                                    withAnimation {
                                        isExpanded = false
                                    }
                                    
                                    searchText = ""
                                    
                                    
                                } label: {
                                    
                                    HStack {
                                        Text(item)
                                            .foregroundColor(.black)
                                        
                                        Spacer()
                                        
                                        if selectedItem == item {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.blue)
                                            
                                        }
                                    }
                                    .padding()
                                }
                                
                                Divider()
                            }
                        }
                    }
                    
                    .frame(maxHeight:200)
                }
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 5)
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                //  .transition(.scale)
                // .frame(width: 200)
                
            }
            }
            
        }
        
    }
}

let data: [DataList] = [
    DataList(title: "Cambodia"),
    DataList( title: "UK"),
    DataList( title: "UKRAN"),
    DataList( title: "Canada"),
//    
//    DataList(title: "Cambodiak"),
//    DataList( title: "UKk"),
//    DataList( title: "UKRANj"),
//    DataList( title: "Canadak"),
//    
//    DataList(title: "Cambodiaj"),
//    DataList( title: "UKj"),
//    DataList( title: "UKRANj"),
//    DataList( title: "Canadan"),
//    
//    DataList(title: "Cambodimk"),
//    DataList( title: "UKo"),
//    DataList( title: "UKRANi"),
//    DataList( title: "Canadaj")
    
]


#Preview {
    CustomDropdownView( data: data)
}


