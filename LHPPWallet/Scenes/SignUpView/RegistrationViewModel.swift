//
//  RegistrationViewModel.swift
//  LHPPWallet
//
//  Created by Cursor on 5/5/26.
//

import Foundation
import SwiftUI
import Combine

@available(iOS 15.0, *)
final class RegistrationViewModel: ObservableObject {
    // MARK: Step 1 - Form
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var dateOfBirth: String = ""
    @Published var preferredName: String = ""
    @Published var email: String = ""

    @Published var province: String = ""
    @Published var district: String = ""
    @Published var commune: String = ""
    @Published var village: String = ""
    @Published var country: String = ""

    @Published var address1: String = ""
    @Published var address2: String = ""
    @Published var address3: String = ""

    @Published var occupation: String = ""
    @Published var gender: String = "M"

    @Published var biometricEnabled: Bool = true
    @Published var notificationEnabled: Bool = false

    // MARK: Step 2 - Documents
    @Published var nationality: String = ""
    @Published var documentType: String = ""
    @Published var documentIdNumber: String = ""

    struct UploadedItem: Identifiable, Equatable {
        let id = UUID()
        let title: String
        let image: UIImage
    }

    enum PickingTarget {
        case document
        case selfie
    }

    @Published var isMediaPickerPresented: Bool = false
    @Published var useCamera: Bool = true
    @Published var pickingTarget: PickingTarget = .document

    @Published var uploadedDocuments: [UploadedItem] = []
    @Published var uploadedSelfies: [UploadedItem] = []

    @Published var previewImage: UIImage? = nil
    @Published var isPreviewPresented: Bool = false

    func presentPicker(target: PickingTarget, useCamera: Bool) {
        self.pickingTarget = target
        self.useCamera = useCamera
        self.isMediaPickerPresented = true
    }

    func addPickedImage(_ image: UIImage) {
        let prefix = useCamera ? "Camera" : "Photo"
        let filename = "\(prefix)_\(Int(Date().timeIntervalSince1970)).png"
        let item = UploadedItem(title: filename, image: image)

        if pickingTarget == .document {
            uploadedDocuments.append(item)
        } else {
            uploadedSelfies.append(item)
        }
    }

    func deleteDocument(id: UploadedItem.ID) {
        uploadedDocuments.removeAll { $0.id == id }
    }

    func deleteSelfie(id: UploadedItem.ID) {
        uploadedSelfies.removeAll { $0.id == id }
    }
}

