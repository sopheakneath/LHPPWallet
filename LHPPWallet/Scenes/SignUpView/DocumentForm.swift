//
//  DocumentForm.swift
//  LHPPWallet
//
//  Created by sopheakneath on 29/4/26.
//

import SwiftUI

@available(iOS 15.0, *)
struct DocumentForm: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
       
        ScrollView {
            HStack{
                VStack{
                    Image("check")
                        .frame(width: 40,height: 40)
                        .background(Color.red)
                        .cornerRadius(20)
                    Text("Fill Form")
                        .foregroundColor(Color.red)
                }
               
               
                Rectangle()
                    .frame(width: 100)
                        .frame(height: 1)
                        .foregroundColor(.red)
                        .padding(.bottom,30)
                        .padding(.trailing, -40)
                    
                VStack {
                    Text("2")
                        .frame(width: 40,height: 40)
                        .background(Color.red)
                        .cornerRadius(20)
                        .foregroundColor(Color.white)
                    Text("Upload Document")
                }
            }
            VStack {
                ValidatedTextField(
                    title: "Choose Nationality",
                    placeHolder: "Nationality",
                    text: $viewModel.nationality,
                    validator: { input in
                        input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "This field is required." : nil
                    }
                )
                
                ValidatedTextField(
                    title: "Choose Document type",
                    placeHolder: "Document Type",
                    text: $viewModel.documentType,
                    validator: { input in
                        input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "This field is required." : nil
                    }  )
                
                
                ValidatedTextField(
                    title: "Document id number",
                    placeHolder: "ID Number",
                    text: $viewModel.documentIdNumber,
                    validator: { input in
                        input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "This field is required." : nil
                    }  )
                
                Text("Document Photo")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack{
                    Image("doc")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(10)
                        .background(Color.lightBlue)
                        .cornerRadius(30)
                    Text("Please upload a valid ID in PNG, JPEG, or PDF format (max 3MB).")
                        .multilineTextAlignment(.center)
                        .font(.maliRegular)
                        .foregroundColor(Color.gray)
                    
                    HStack {
                        Button {
                            viewModel.presentPicker(target: .document, useCamera: true)
                        } label: {
                            HStack{
                                Image("camera")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                   
                                Text("use camare")
                                    .lineLimit(1)
                            }
                            .padding(.horizontal, 30)
                            .padding(.vertical, 7)
                            .overlay(
                                   RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.blue, lineWidth: 0.5)
                               )
                          
                           // .cornerRadius(30)
                        }
                      
                           
                        Spacer()
                        
                        Button {
                            viewModel.presentPicker(target: .document, useCamera: false)
                               
                        } label: {
                            HStack{
                                Image("cloud")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("upload")
                                    .lineLimit(1)
                            }
                            .padding(.horizontal, 30)
                            .padding(.vertical, 7)
                            .overlay(
                                   RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.blue, lineWidth: 0.5)
                                    
                               )
                        }
                      
                       
                    }
                    .padding(.top, 30)
                    .foregroundColor(Color.blue)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .background(
                    LinearGradient(
                        colors: [.brightBlue, .brightGray, .white],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay(
                       RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.lightGray, lineWidth: 1)
                        
                   )
                .cornerRadius(8)
             
                if !viewModel.uploadedDocuments.isEmpty {
                    Text("Uploaded")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                   
               
                ForEach(viewModel.uploadedDocuments) { item in
                    StoreImageView(title: item.title, onPreview: {
                        viewModel.previewImage = item.image
                        viewModel.isPreviewPresented = true
                    }, onDelete: {
                        viewModel.deleteDocument(id: item.id)
                    })
                }
                
                
                
                Text("Selfie Photo")
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack{
                    Image("doc")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(10)
                        .background(Color.lightBlue)
                        .cornerRadius(30)
                    Text("Please upload a valid ID in PNG, JPEG, or PDF format (max 3MB).")
                        .multilineTextAlignment(.center)
                        .font(.maliRegular)
                        .foregroundColor(Color.gray)
                        
                    
                    HStack {
                        Button {
                            viewModel.presentPicker(target: .selfie, useCamera: true)
                        } label: {
                            HStack{
                                Image("camera")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("take photo")
                                    .lineLimit(1)
                                   
                                
                            }
                            .padding(.horizontal, 30)
                            .padding(.vertical, 7)
                            .overlay(
                                   RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.blue, lineWidth: 0.5)
                               )
                        }
                      
                           
                        Spacer()
                        Button {
                            viewModel.presentPicker(target: .selfie, useCamera: false)
                           
                        } label: {
                            HStack{
                                Image("cloud")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("upload")
                                    .lineLimit(1)
                            }
                            .padding(.horizontal, 30)
                            .padding(.vertical, 7)
                            .overlay(
                                   RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.blue, lineWidth: 0.5)
                               )
                           
                        }
                      
                       
                    }
                    .padding(.top, 30)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .background(
                    LinearGradient(
                        colors: [.brightBlue, .brightGray, .white],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay(
                       RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.lightGray, lineWidth: 1)
                        
                   )
                .cornerRadius(8)
             
                
                if !viewModel.uploadedSelfies.isEmpty {
                    Text("Uploaded")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                ForEach(viewModel.uploadedSelfies) { item in
                    StoreImageView(title: item.title, onPreview: {
                        
                        viewModel.previewImage = item.image
                        viewModel.isPreviewPresented = true
                    }, onDelete: {
                        viewModel.deleteSelfie(id: item.id)
                    })
                }
                
                
                NavigationLink{
                    RegisterCompletedView()
                }label:{
                    Text("Proccess")
                      //  .background(Color.blue)
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                       
                        
                }
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(8)
                .padding(.top, 50)
                
                
            }
           
            .padding(.horizontal, 20)
            
           
        }
        .customBackToolbar(title: "Registration")
        .sheet(isPresented: $viewModel.isMediaPickerPresented) {
            if viewModel.useCamera {
                CameraPicker(sourceType: .camera) { pickedImage in
                    viewModel.addPickedImage(pickedImage)
                }
            } else {
                CameraPicker(sourceType: .photoLibrary) { pickedImage in
                    viewModel.addPickedImage(pickedImage)
                }
            }
        }
        .sheet(isPresented: $viewModel.isPreviewPresented) {
            if let previewImage = viewModel.previewImage {
                VStack {
                    Image(uiImage: previewImage)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
            }
        }
    }
    
        
}

#Preview {
    if #available(iOS 15.0, *) {
        DocumentForm()
            .environmentObject(RegistrationViewModel())
    } else {
        // Fallback on earlier versions
    }
}

// -----------------------------------


