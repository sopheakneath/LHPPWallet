//
//  TransferViewModel.swift
//  LHPPWallet
//
//  Created by sopheakneath on 10/4/26.
//

import Foundation
import Combine
import UIKit
import SwiftUI


class TransferViewModel: ObservableObject {
    private let service = TransferSevice.shared
  
    @Published var item : [walletListModel] = []
    
    
    func fetchWalletList(){
        
        service.getWalletList { [ weak self] data in
           //self?.item = data
            self?.item = data
        }
       
    }
}
