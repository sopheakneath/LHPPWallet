//
//  WalletInfoViewModel.swift
//  LHPPWallet
//
//  Created by sopheakneath on 6/4/26.
//

import Foundation
import UIKit
import Combine

class WalletInfoViewModel : ObservableObject {
    
    // TextField
    
    @Published  var firstName: String = ""
    @Published  var lastName: String = ""
    @Published  var name: String = ""
    @Published  var mail: String = ""
    @Published  var password: String = ""
    
    //address info
    
    @Published  var province: String = ""
    @Published  var District: String = ""
    @Published  var commune: String = ""
    @Published  var village: String = ""
    @Published  var country: String = ""
    @Published  var Address: String = ""
    @Published  var Address1 : String = ""
    @Published  var occupation : String = ""
    //
    
    @Published var errorMessage: String = ""
    @Published var submitted: Bool = false
    @Published var showMessage: Bool = false
    
    
    private var hasMissingRequiredFields: Bool {
        firstName.isEmpty || lastName.isEmpty || name.isEmpty
    }

    func ValidateField() -> Bool {
        return !hasMissingRequiredFields
    }
    
    func saveInfo() {
        if hasMissingRequiredFields {
            self.showMessage = true
          //  errorMessage = AppError.noData.localizedDescription
        } else {
          //  errorMessage = ""
            self.submitted = true
        }
        
    }
    
}
