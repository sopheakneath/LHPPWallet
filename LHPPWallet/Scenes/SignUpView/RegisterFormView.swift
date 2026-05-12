//
//  RegisterFormView.swift
//  LHPPWallet
//
//  Created by Sopheakneath on 28/3/26.
//

import SwiftUI


struct RegisterFormView: View {
    @StateObject private var viewModel = RegistrationViewModel()
    @State private var dateOfBirthDate: Date = Date()
    @State private var isDobPickerPresented: Bool = false
    @State private var selectedGender: DropdownItem?
    @State private var showPicker: Bool = false
    @State private var showProvincePicker: Bool = false
    @State private var isExpanded = false
    
    let provind = [
        DropdownItem(title: "kompong change"),
        DropdownItem(title: "Seamreap"),
        DropdownItem(title: "Batdombong"),
        DropdownItem(title: "preh vihear"),
    ]
    
    let dataProvince: [DataList] = [
        DataList(title: "Cambodia"),
        DataList( title: "UK"),
        DataList( title: "UKRAN"),
        DataList( title: "Canada"),
        
        DataList(title: "Cambodiak"),
        DataList( title: "UKk"),
        DataList( title: "UKRANj"),
        DataList( title: "Canadak"),
        
        DataList(title: "Cambodiaj"),
        DataList( title: "UKj"),
        DataList( title: "UKRANj"),
        DataList( title: "Canadan"),
        
        DataList(title: "Cambodimk"),
        DataList( title: "UKo"),
        DataList( title: "UKRANi"),
        DataList( title: "Canadaj")
        
    ]
    
    let District: [DataList] = [
        DataList(title: "russy koe"),
        DataList( title: "tek tla"),
        DataList( title: "sen sok"),
        DataList( title: "don penh"),
    ]
    @State private var selectedFruit = "kompong change"

       let fruits = ["Apple", "Banana", "Orange"]
    
    var body: some View {
    
   // NavigationView{
        ScrollView {
                HStack{
                    VStack{
                        Text("1")
                            .frame(width: 40,height: 40)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(20)
                        Text("Fill Form")
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
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .cornerRadius(20)
                        Text("Update Document")
                    }
                    
                }
                
             
                    ValidatedTextField(title: "First Name", placeHolder: "First Name", text: $viewModel.firstName, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
                    
                    ValidatedTextField(title: "Last name", placeHolder: "Last Name", text: $viewModel.lastName, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
                      
                
                ValidatedTextField(title: "User name", placeHolder: "User Name", text: $viewModel.userName, validator: { value in
                    if value.trimmingCharacters(in: .whitespacesAndNewlines).count < 7 {
                        return "user name is required"
                    }
                    return nil
                    
                }, keyboardType: .default, isSecure: false, isTitleFrame: false)
                ValidatedTextField(title: "password", placeHolder: "Password",
                                   text: $viewModel.password,
                                   validator: { value in
                                       if value.trimmingCharacters(in: .whitespacesAndNewlines).count < 4 {
                                           return "Password most be at leasr 8 charater"
                                       }
                                       return nil
                                   },
                                   
                                   keyboardType: .numberPad,
                                   isSecure: true,
                                   isTitleFrame: false
                                   
                )
            ValidatedTextField(title: "Nick Name", placeHolder: "Nick Name", text: $viewModel.preferredName, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: true, isTitleFrame: false)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Date of birtd")
                    .font(.maliRegular)
                
                HStack {
                    Text(viewModel.dateOfBirth.isEmpty ? "yyyy-MM-dd" : viewModel.dateOfBirth)
                        .font(.maliRegular)
                        .foregroundColor(viewModel.dateOfBirth.isEmpty ? .secondary : .primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        isDobPickerPresented = true
                    } label: {
                        Image(systemName: "calendar")
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .strokeBorder(Color.secondary, lineWidth: 0.5)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color(.white))
                        )
                )
            }
            .padding(.bottom, 19)
            .onAppear {
                viewModel.dateOfBirth = dobFormatter.string(from: dateOfBirthDate)
            }
            .onChange(of: dateOfBirthDate) { newValue in
                viewModel.dateOfBirth = dobFormatter.string(from: newValue)
            }
            
            .sheet(isPresented: $isDobPickerPresented) {
                VStack(spacing: 16) {
                    Text("Select Date of Birth")
                        .font(.headline)
                    
                    DatePicker(
                        "",
                        selection: $dateOfBirthDate,
                        in: ...Date(),
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                    
                    Button("Done") {
                        isDobPickerPresented = false
                    }
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.primaryBlue)
                    )
                    .foregroundColor(.white)
                }
                .padding()
            }
         
           
            
            ValidatedTextField(title: "Emain", placeHolder: "Email adress (optional)", text: $viewModel.email, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
            
            
            ValidatedTextField(title: "province", placeHolder: "select province", text: $viewModel.province, validator: {
                value in value.isEmpty ? "Please select province" : nil
            })
            
//            VStack(alignment: .leading, spacing: 0) {
//                Text("Province")
//                    .font(.maliRegular)
//                HStack(spacing: 0) {
//                    TextField("Province", text: $viewModel.province)
//                        .font(.maliRegular)
//                        .foregroundColor(.primary)
//                    Spacer(minLength: 8)
//                    Menu {
//                        ForEach(provind, id: \.title) { item in
//                            Button(item.title) {
//                                viewModel.province = item.title
//                            }
//                        }
//                    } label: {
//                        HStack(spacing: 0) {
//                            
////                            Text(viewModel.province.isEmpty ? "Select" : viewModel.province)
////                                .foregroundColor(viewModel.province.isEmpty ? .secondary : .accentColor)
//                            Image(systemName: "chevron.down")
//                                .foregroundColor(.secondary)
//                        }
//                      //  .padding(.horizontal, 10)
//                        //.padding(.vertical, 6)
//                        //
//                    }
//                }
//                .padding(.horizontal, 12)
//                .padding(.vertical, 10)
//                .background(
//                    RoundedRectangle(cornerRadius: 8, style: .continuous)
//                        .strokeBorder(Color.secondary, lineWidth: 0.5)
//                        .background(
//                            RoundedRectangle(cornerRadius: 10, style: .continuous)
//                                .fill(Color(.white))
//                        )
//                )
//            }
//            .padding(.bottom, 19)
//            .background(Color.red)
            
            
            // TESTING customDropDown ---------------------
            CustomDropdownView(data: dataProvince)
            Text("Disctrict")
                .font(.maliRegular)
                .frame(maxWidth: .infinity, alignment: .leading)
            CustomDropdownView(data: District)
                .padding(.vertical, 20)
               
            ValidatedTextField(title: "District", placeHolder: "District", text: $viewModel.district, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false,trailingSystemImageName: "drop_down",onTrailingIconTap: {
                isExpanded.toggle()
                print("list all District")
            })
            if isExpanded {
                ZStack(alignment: .topLeading){
                    VStack{
                        Text("hello list")
                        Text("hello list")
                        Text("hello list")
                    }
                }
                .background(Color.green)
                .offset(y: 0)
                .transition(.scale)
                
               
            }
            
           
            ValidatedTextField(title: "Commune (Optional)", placeHolder: "Commune (Optional)", text: $viewModel.commune, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false,trailingSystemImageName: "drop_down",onTrailingIconTap: {
                print("list all ptovince")
            })
            ValidatedTextField(title: "Village (Optional)", placeHolder: "Village (Optional)", text: $viewModel.village, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false,trailingSystemImageName: "drop_down",onTrailingIconTap: {
                print("list all ptovince")
            })
            ValidatedTextField(title: "Country", placeHolder: "Country", text: $viewModel.country, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false,trailingSystemImageName: "drop_down",onTrailingIconTap: {
                print("list all ptovince")
            })
            
            ValidatedTextField(title: "Address", placeHolder: "Address", text: $viewModel.address1, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
            
            ValidatedTextField(title: "Address 2 (Optional)", placeHolder: "Address 2 (Optional)", text: $viewModel.address2, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
            
            ValidatedTextField(title: "Address 3 (Optional)", placeHolder: "Address 3 (Optional)", text: $viewModel.address3, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
            
            ValidatedTextField(title: "Gender", placeHolder: "Gender", text: $viewModel.gender, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false)
            
            ValidatedTextField(title: "Occupation", placeHolder: "Occupation", text: $viewModel.occupation, validator: { value in value.isEmpty ? "" : nil }, keyboardType: .numberPad, isSecure: false, isTitleFrame: false,trailingSystemImageName: "drop_down",onTrailingIconTap: {
                print("list all ptovince")
            })
            
//
//
//                HStack(spacing: 0) {
//                        genderButton(title: "Male", value: "M")
//                        genderButton(title: "Female", value: "F")
//                    }
//                    .background(Color.gray.opacity(0.2))
//                    .cornerRadius(30)
//                    .padding(.horizontal, 30)
//                    .onChange(of: gender, perform: {newValue in
//                        print("hello \(newValue)")
//                    },  )

                
                NavigationLink{
                   // LoginView()
                    DocumentForm()
                        .environmentObject(viewModel)
                }label: {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        
                        .font(.maliRegular)
                       
                        .foregroundColor(Color.white)
                       // .background(Color(hex:"#286CB3"))
                        .background(Color.primaryBlue)
                        .cornerRadius(8)
                       // .padding(.horizontal, 90)
                       
                }
               // .frame(maxWidth: .infinity)
               // .padding(.top, 50)
                
            }
            
            .padding(.horizontal, 14)
            .background(Color.brightGray)
            .customBackToolbar(title: "Account Registration")
        }
    
   
      
   // }
}


private let dobFormatter: DateFormatter = {
    let df = DateFormatter()
    df.calendar = Calendar(identifier: .gregorian)
    df.locale = Locale(identifier: "en_US_POSIX")
    df.dateFormat = "yyyy-MM-dd"
    return df
}()


extension RegisterFormView {
    func genderButton(title: String, value: String) -> some View {
        Button(action: {
            viewModel.gender = value
        }) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(viewModel.gender == value ? Color.blue : Color.clear)
                .foregroundColor(viewModel.gender == value ? .white : .black)
                .cornerRadius(30)
        }
    }
}


#Preview {
   
RegisterFormView()
    
}

