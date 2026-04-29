//
//  TransactionViewModel.swift
//  LHPPWallet
//
//  Created by sopheakneath on 25/3/26.
//

import Foundation
import SwiftUI
import UIKit
import Combine

class TransactionViewModel : ObservableObject {
    private let service = TransactionSevice.shared
    @Published var item : [TransactionModel] = []
    @Published var isloading : Bool = false
    
    func getTransaction(){
        self.isloading = true
        service.getNotifications { [weak self] data in
            DispatchQueue.main.async {
                self?.isloading = false
                self?.item = data
            }
        }
    }
    
    func getMockDta(){
        print("Hello , hello")
    }
}
