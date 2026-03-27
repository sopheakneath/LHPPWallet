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
    
    func getTransaction(){
        service.getNotifications { [weak self] data in
            
            DispatchQueue.main.async {
                self?.item = data
            }
        }
    }
    
    func getMockDta(){
        print("Hello , hello")
    }
}
