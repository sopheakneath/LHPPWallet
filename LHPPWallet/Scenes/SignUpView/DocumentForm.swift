//
//  DocumentForm.swift
//  LHPPWallet
//
//  Created by sopheakneath on 29/4/26.
//

import SwiftUI

@available(iOS 15.0, *)
struct DocumentForm: View {
    @State var nationality: String = ""
    @State var isUploaded : Bool = false
    
    @State private var isMediaPickerPresented: Bool = false
    @State private var useCamera: Bool = true
    @State private var image: UIImage?
    
    @State private var uploadedItems: [UploadedItem] = []
    @State private var uploadedSelfie: [UploadedItem] = []
    @State private var previewImage: UIImage? = nil
    @State private var isPreviewPresented: Bool = false
    
    struct UploadedItem: Identifiable {
        let id = UUID()
        let title: String
        let image: UIImage
    }
    
    enum PickingTarget {
        case document
        case selfie
    }
    
    @State private var pickingTarget: PickingTarget = .document
    
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
                            pickingTarget = .document
                            useCamera = true
                            isMediaPickerPresented = true
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
                            pickingTarget = .document
                            useCamera = false
                            isMediaPickerPresented = true
                               
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
             
                if !uploadedItems.isEmpty {
                    Text("Uploaded")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                   
               
                ForEach(uploadedItems) { item in
                    StoreImageView(title: item.title, onPreview: {
                        previewImage = item.image
                        isPreviewPresented = true
                    }, onDelete: {
                        if let index = uploadedItems.firstIndex(where: { $0.id == item.id }) {
                            uploadedItems.remove(at: index)
                        }
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
                            pickingTarget = .selfie
                            useCamera = true
                            isMediaPickerPresented = true
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
                            pickingTarget = .selfie
                            useCamera = false
                            isMediaPickerPresented = true
                           
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
             
                
                if !uploadedSelfie.isEmpty {
                    Text("Uploaded")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                ForEach(uploadedSelfie) { item in
                    StoreImageView(title: item.title, onPreview: {
                        
                        previewImage = item.image
                        isPreviewPresented = true
                    }, onDelete: {
                        if let index = uploadedSelfie.firstIndex(where: { $0.id == item.id }) {
                            uploadedSelfie.remove(at: index)
                        }
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
        .sheet(isPresented: $isMediaPickerPresented) {
            if useCamera {
                CameraPicker(sourceType: .camera) { pickedImage in
                    self.image = pickedImage
                    let filename = useCamera ? "Camera_\(Int(Date().timeIntervalSince1970)).png" : "Photo_\(Int(Date().timeIntervalSince1970)).png"
                    let item = UploadedItem(title: filename, image: pickedImage)
                    if pickingTarget == .document {
                        uploadedItems.append(item)
                    } else {
                        uploadedSelfie.append(item)
                    }
                }
            } else {
                CameraPicker(sourceType: .photoLibrary) { pickedImage in
                    self.image = pickedImage
                    let filename = useCamera ? "Camera_\(Int(Date().timeIntervalSince1970)).png" : "Photo_\(Int(Date().timeIntervalSince1970)).png"
                    let item = UploadedItem(title: filename, image: pickedImage)
                    
                    if pickingTarget == .document {
                        uploadedItems.append(item)
                    } else {
                        uploadedSelfie.append(item)
                    }
                }
            }
        }
        .sheet(isPresented: $isPreviewPresented) {
            if let previewImage {
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
        DocumentForm(nationality: "NATION")
    } else {
        // Fallback on earlier versions
    }
}

// -----------------------------------


