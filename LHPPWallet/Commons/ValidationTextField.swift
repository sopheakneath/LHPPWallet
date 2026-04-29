//
//  ValidationTextField.swift
//  LHPPWallet
//
//  Created by sopheakneath on 16/3/26.
//

import SwiftUI

//@available(iOS 17.0, *)
struct ValidatedTextField: View {
    let title: String?
    let placeHolder: String?
    // let imageName: String?
    @Binding var text: String
    var validator: (String) -> String?
    var keyboardType: UIKeyboardType = .default
    var isSecure: Bool = false
    var isTitleFrame: Bool = false
    let isImage: Bool = true
    
    @State private var error: String? = nil
    var isFocused: Bool = false
    var isSubmit: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if let placeHolder, !placeHolder.isEmpty {
                Text(placeHolder)
                    .font(.maliBold)
                   // .foregroundStyle(.secondary)
            }
            Group {
                HStack{
                    Image(systemName: "person")
                        .scaledToFit()
                        .frame(width: 20,height: 20)
                        .foregroundColor(.secondary)
                    if isSecure {
                        SecureField(title ?? "", text: $text)
                            .textContentType(.password)
                            .keyboardType(keyboardType)
                            .autocorrectionDisabled(true)
                    } else {
                        TextField(title ?? "", text: $text)
                            .font(.maliRegular)
                            .keyboardType(keyboardType)
                            .autocorrectionDisabled(true)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .strokeBorder(borderColor, lineWidth: 1)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                               .fill(Color(.white))
                        )
                )
                .onChange(of: text) { _ in

                    error = validator(text)
                }
               
                
              if  isSubmit {
                    if let error = error, !error.isEmpty {
                        
                        Text(error)
                            .font(.maliRegular)
                            .foregroundColor(Color.red)
                            
                            .accessibilityLabel("Error: \(error)")
                    }
                }
               
            }
            .padding(.vertical, 1)
        }
        .onAppear { validate() }
        .padding(.bottom, 19)
    }

    private var borderColor: Color {
//        if let error = error, !error.isEmpty {
//            return .red
//        }
        if isSubmit {
            return .red
        }
        return isFocused ? .accentColor : .secondary
    }

    private func validate() {
        error = validator(text)
    }
}

#Preview {
    @State var previewText: String = ""
    if #available(iOS 17.0, *) {
        ValidatedTextField(
            title: "", placeHolder: "",
            text: .constant("FULL "),
            validator: { value in
                // Example: require at least 3 characters
                return value.count >= 3 ? nil : "Must be at least 3 characters"
            }, isFocused: true
        )
    } else {
        // Fallback on earlier versions
    }
}
