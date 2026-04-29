//
//  DocumentForm.swift
//  LHPPWallet
//
//  Created by sopheakneath on 29/4/26.
//

import SwiftUI

struct DocumentForm: View {
    @State var nationality: String = ""
    @State var isUploaded : Bool = false
    var body: some View {
       
        ScrollView {
            HStack{
                Image("check")
                    .frame(width: 40,height: 40)
                    .background(Color.red)
                    .cornerRadius(20)
               
                Text("---------------")
                    .foregroundColor(Color.red)
               
                Text("2")
                    .frame(width: 40,height: 40)
                    .background(Color.red)
                    .cornerRadius(20)
                    .foregroundColor(Color.white)
                
               
            }
            VStack {
                ValidatedTextField(
                    title: "Choose Nationality",
                    placeHolder: "Nationality",
                    text: $nationality,
                    validator: { input in
                        input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "This field is required." : nil
                    }
                )
                
                ValidatedTextField(
                    title: "Choose Document type",
                    placeHolder: "Document Type",
                    text: $nationality,
                    validator: { input in
                        input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "This field is required." : nil
                    }  )
                
                
                ValidatedTextField(
                    title: "Document id number",
                    placeHolder: "ID Number",
                    text: $nationality,
                    validator: { input in
                        input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "This field is required." : nil
                    }  )
                
                Text("Document Photo")
                VStack{
                    Image("doc")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .cornerRadius(30)
                    Text("Please upload a valid ID in PNG, JPEG, or PDF format (max 3MB).")
                        .font(.maliRegular)
                        .foregroundColor(Color.gray)
                    
                    HStack {
                        Button {
                            
                        }label: {
                            HStack{
                                Image("camera")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("take photo")
                                    .lineLimit(1)
                                   
                                
                            }
                            .padding(.horizontal, 30)
                            .padding(.vertical, 7)
                            
                            .background(Color.white)
                            .cornerRadius(30)
                        }
                      
                           
                        Spacer()
                        
                        .padding()
                        Button {
                        }label: {
                            HStack{
                                Image("cloud")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("upload")
                                    .lineLimit(1)
                            }
                            .padding(.horizontal, 30)
                            .padding(.vertical, 7)
                            .background(Color.white)
                            .cornerRadius(30)
                        }
                      
                       
                    }
                    .padding(.top, 30)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
               // .background(Color.lightBlue)
                .background(
                    LinearGradient(
                        colors: [.lightBlue, .white],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(8)
                
                StoreImageView()
                
                Text("Selfie Photo")
                VStack{
                    Image("doc")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .cornerRadius(30)
                    Text("Please upload a valid ID in PNG, JPEG, or PDF format (max 3MB).")
                        .font(.maliRegular)
                        .foregroundColor(Color.gray)
                    
                    HStack {
                        Button {
                            
                        }label: {
                            HStack{
                                Image("camera")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("take photo")
                                    .lineLimit(1)
                                   
                                
                            }
                            .padding(.horizontal, 30)
                            .padding(.vertical, 7)
                            
                            .background(Color.prettyGreen)
                            .cornerRadius(30)
                        }
                      
                           
                        Spacer()
                        Button {
                        }label: {
                            HStack{
                                Image("cloud")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("upload")
                                    .lineLimit(1)
                            }
                            .padding(.horizontal, 30)
                            .padding(.vertical, 7)
                            .background(Color.prettyGreen)
                            .cornerRadius(30)
                        }
                      
                       
                    }
                    .padding(.top, 30)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .background(
                    LinearGradient(
                        colors: [.lightBlue, .white],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .shadow(radius: 10)
                .cornerRadius(8)
                
                
                StoreImageView()
                
                
                Button{}label: {
                    Text("Proccess")
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 5)
                       
                        
                }
                
                
            }
           
            .padding(.horizontal, 20)
            
           
        }
        .customBackToolbar(title: "Registration")
    }
}

#Preview {
    DocumentForm(nationality: "NATION")
}
