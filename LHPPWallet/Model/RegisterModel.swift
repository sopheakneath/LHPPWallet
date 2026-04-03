//
//  RegisterModel.swift
//  LHPPWallet
//
//  Created by sopheakneath on 2/4/26.
//

import Foundation
import Combine
import SwiftUI
import UIKit

struct RegisterModel: Codable {
    let fk: String
    let deviceId: String
    let handle: String
    let lang: String
    //let fullName: Name
    let firstName : FirstMiddleName
    let lastName : String
    let preferredName: String
    let gender: String
    let dob: String
    let userName: String
    let userPass: String
    let timeStamp: String
    let type: Int
    let challengeKey: String
    let referalCode: String
}

struct FirstMiddleName: Codable {
  var firstName: String
  var middleName: String
  
  init(fullName: String) {
//    let strName = fullName.components(separatedBy: " ")
//    firstName = strName[0]
//    middleName = strName[1]
    
    let trimmedString = fullName.trimmingCharacters(in: .whitespacesAndNewlines)
    let strName = trimmedString.components(separatedBy: " ")
    firstName = String(strName[0])
    middleName = String((strName.count > 1 ? strName[1] : nil) ?? "")
    print(strName)
    print(firstName)
    print(middleName)
    
  }
}


func getDeviceUUID() -> String {
    let key = "device_uuid"
    
    if let saved = UserDefaults.standard.string(forKey: key) {
        return saved
    } else {
        let newId = UUID().uuidString
        UserDefaults.standard.set(newId, forKey: key)
        return newId
    }
}
