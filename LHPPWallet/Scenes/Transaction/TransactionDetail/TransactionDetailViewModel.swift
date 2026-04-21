//
//  TransactionDetailViewModel.swift
//  LHPPWallet
//
//  Created by sopheakneath on 20/4/26.
//

import Foundation
import Combine
import UIKit
import SwiftUI


class TransactionDetailViewModel : ObservableObject {
    
    @Published var transactionDetail: TransactionDetailModel?
    
    private let serviceTra = TransactionSevice()
       
       func fetchTransactionDetail(txnNo: String) {
           transactionDetail = serviceTra.getTransactionDetail(txnNoInCbs: "TXN002")
          // transactionDetail = serviceTra.getTransactionDetail(txnNoInCbs: txnNo)
       }
   
}
