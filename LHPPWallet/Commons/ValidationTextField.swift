//
//  ValidationTextField.swift
//  LHPPWallet
//
//  Created by sopheakneath on 16/3/26.
//

import SwiftUI

struct ValidatedTextField: View {
    let title: String?
    let placeHolder: String?
    @Binding var text: String
    var validator: (String) -> String?
    var keyboardType: UIKeyboardType = .default
    var isSecure: Bool = false
    var isTitleFrame: Bool = false
    

    @State private var error: String? = nil
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if let placeHolder, !placeHolder.isEmpty {
                Text(placeHolder)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Group {
                HStack{
                    Image(systemName: "heart.fill")
                        .scaledToFit()
                        .frame(width: 20,height: 20)
                        .foregroundColor(.secondary)
                    if isSecure {
                        
                        SecureField(title ?? "", text: $text)
                            .textContentType(.password)
                            .keyboardType(keyboardType)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .focused($isFocused)
                            .submitLabel(.done)
                            .onSubmit(validate)
                    } else {
                        TextField(title ?? "", text: $text)
                            .keyboardType(keyboardType)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .focused($isFocused)
                            .submitLabel(.done)
                            .onSubmit(validate)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .strokeBorder(borderColor, lineWidth: 1)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color(.secondarySystemBackground))
                        )
                )
                .onChange(of: text) { _ in
                    // Live validate while typing
                    error = validator(text)
                }
                
                if let error = error, !error.isEmpty {
                    Text(error)
                        .font(.footnote)
                        .foregroundStyle(.red)
                        .accessibilityLabel("Error: \(error)")
                }
            }
        }
        .onAppear { validate() }
    }

    private var borderColor: Color {
        if let error = error, !error.isEmpty {
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
    ValidatedTextField(
        title: "", placeHolder: "",
        text: .constant("FULL "),
        validator: { value in
            // Example: require at least 3 characters
            return value.count >= 3 ? nil : "Must be at least 3 characters"
        }
    )
}
