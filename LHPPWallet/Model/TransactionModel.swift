//
//  TransactionModel.swift
//  LHPPWallet
//
//  Created by sopheakneath on 24/3/26.
//
import SwiftUI
import Foundation
import UIKit

struct TransactionModel: Codable {
    
    let txnNoInCbs : String
    let txnRefNo : String
    let isDebit : Bool
    let debitAccName : String
    let accountName : String
    let debitAccNo : String
    let creditAccNo : String
    let icon : String
    let currency : String
    let creditAccName : String
    let isPayment : Bool
    let title : String
    let txnDescription : String
    let accountId : String
    let txnDate : String
    let amount : Double
    let txnType : String

}

class TransactionSevice {
    static let shared = TransactionSevice()
    func getNotifications(completion: @escaping ([TransactionModel]) -> ()) {
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.init(TransactionModel.mock))
        }}
    
    
    func getTransactionDetail(txnNoInCbs: String) -> TransactionDetailModel? {
        return TransactionDetailModel.mockTransactions.first { $0.txnNoInCbs == txnNoInCbs }
       }
}
 
 
struct TransactionDetailModel: Codable, Identifiable {
    let id = UUID()
    let txnNoInCbs: String
    let amount: Double
    let currency: String
    let date: String
    let status: String
    let description: String
    let senderAcc: String
    let receiverAcc: String
    let trxNum: String
    let AuthNUM: String
    let feeAmount: String
    
}



//class TransactionSevice {
//    static let share = TransactionSevice()
//    func getListTransaction(completion: ([TransactionModel])) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
//            completion(.init(TransactionModel.mock))
//        }
//    }
//}


extension TransactionModel {
    static let mock : [TransactionModel] = [
        TransactionModel(txnNoInCbs: "TXN001", txnRefNo: "FTQR260830810000009", isDebit: true, debitAccName: "Sopheakneath,", accountName: "Sopheakneath sopheak ", debitAccNo: "000482502", creditAccNo: "000483990", icon: "bakong", currency: "USD", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to Nang", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "24 Mar 2026, 11:37 AM", amount: 50, txnType: "1021"),
        
        TransactionModel(txnNoInCbs: "TXN002", txnRefNo: "FTQR260830810000009", isDebit: false, debitAccName: "Nita,", accountName: "Nita", debitAccNo: "000482502", creditAccNo: "000483990", icon: "", currency: "KHQR", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to merchant", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "24 Mar 2026, 11:35 AM", amount: 12.3, txnType: "1021"),
        
        TransactionModel(txnNoInCbs: "TXN003", txnRefNo: "FTQR260830810000009", isDebit: false, debitAccName: "Makara71,", accountName: "Navy", debitAccNo: "000482502", creditAccNo: "000483990", icon: "bakong", currency: "USD", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "24 Mar 2026, 11:38 AM", amount: 23.20, txnType: "1021"),
        
        TransactionModel(txnNoInCbs: "123", txnRefNo: "FTQR260830810000009", isDebit: true, debitAccName: "Makara71,", accountName: "Wing bank", debitAccNo: "000482502", creditAccNo: "000483990", icon: "wing", currency: "USD", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "24 Mar 2026, 12:37 AM", amount: 3.45, txnType: "1021"),
        
        TransactionModel(txnNoInCbs: "TXN005", txnRefNo: "FTQR260830810000009", isDebit: true, debitAccName: "Makara71,", accountName: "ABA Bank", debitAccNo: "000482502", creditAccNo: "000483990", icon: "aba", currency: "USD", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "24 Mar 2026, 12:40 AM", amount: 0.54, txnType: "1021"),
        
        TransactionModel(txnNoInCbs: "TXN006", txnRefNo: "FTQR260830810000009", isDebit: true, debitAccName: "Makara71,", accountName: "Tester", debitAccNo: "000482502", creditAccNo: "000483990", icon: "ic_language_kh", currency: "USD", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "24 Mar 2026, 11:50 AM", amount: 2.89, txnType: "1021"),
        
        TransactionModel(txnNoInCbs: "TXN007", txnRefNo: "FTQR260830810000009", isDebit: false, debitAccName: "Makara71,", accountName: "SmartBaaS", debitAccNo: "000482502", creditAccNo: "000483990", icon: "", currency: "KHQR", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "23 Mar 2026, 11:37 AM", amount: 30.00, txnType: "1021"),
        
        TransactionModel(txnNoInCbs: "TXN008", txnRefNo: "FTQR260830810000009", isDebit: false, debitAccName: "Makara71,", accountName: "Makara", debitAccNo: "000482502", creditAccNo: "000483990", icon: "", currency: "USD", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "23 Mar 2026, 11:20 AM", amount: 50.09, txnType: "1021"),
        
        TransactionModel(txnNoInCbs: "TXN009", txnRefNo: "FTQR260830810000009", isDebit: true, debitAccName: "Makara71,", accountName: "Makara", debitAccNo: "000482502", creditAccNo: "000483990", icon: "", currency: "USD", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "23 Mar 2026, 10:37 AM", amount: 43.44, txnType: "1021"),
        
        TransactionModel(txnNoInCbs: "TXN0010", txnRefNo: "FTQR260830810000009", isDebit: true, debitAccName: "Makara71,", accountName: "Makara", debitAccNo: "000482502", creditAccNo: "000483990", icon: "", currency: "USD", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "23 Mar 2026, 10:40 AM", amount: 04.00, txnType: "1021"),
        
        TransactionModel(txnNoInCbs: "FT260831PH0W", txnRefNo: "FTQR260830810000009", isDebit: true, debitAccName: "Makara71,", accountName: "Makara", debitAccNo: "000482502", creditAccNo: "000483990", icon: "", currency: "USD", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "22 Mar 2026, 11:37 AM", amount: 90.00, txnType: "1021"),
        
        TransactionModel(txnNoInCbs: "FT260831PH0W", txnRefNo: "FTQR260830810000009", isDebit: true, debitAccName: "Makara71,", accountName: "Makara", debitAccNo: "000482502", creditAccNo: "000483990", icon: "", currency: "KHQR", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "21 Mar 2026, 11:37 AM", amount: 34, txnType: "1021"),
        
        TransactionModel(txnNoInCbs: "FT260831PH0W", txnRefNo: "FTQR260830810000009", isDebit: true, debitAccName: "Makara71,", accountName: "Makara", debitAccNo: "000482502", creditAccNo: "000483990", icon: "", currency: "KHQR", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "21 Mar 2026, 07:37 AM", amount: 34, txnType: "1021"),
        
        TransactionModel(txnNoInCbs: "FT260831PH0W", txnRefNo: "FTQR260830810000009", isDebit: true, debitAccName: "Makara71,", accountName: "Makara", debitAccNo: "000482502", creditAccNo: "000483990", icon: "", currency: "KHQR", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "21 Mar 2026, 07:37 PM", amount: 34, txnType: "1021"),
        
        TransactionModel(txnNoInCbs: "FT260831PH0W", txnRefNo: "FTQR260830810000009", isDebit: true, debitAccName: "Makara71,", accountName: "Makara", debitAccNo: "000482502", creditAccNo: "000483990", icon: "", currency: "KHQR", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "12 Mar 2026, 11:30 AM", amount: 34, txnType: "1021"),
        
        TransactionModel(txnNoInCbs: "FT260831PH0W", txnRefNo: "FTQR260830810000009", isDebit: true, debitAccName: "Makara71,", accountName: "Makara", debitAccNo: "000482502", creditAccNo: "000483990", icon: "", currency: "KHQR", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "12 Mar 2026, 11:25 AM", amount: 34, txnType: "1021"),
        
        TransactionModel(txnNoInCbs: "FT260831PH0W", txnRefNo: "FTQR260830810000009", isDebit: true, debitAccName: "Makara71,", accountName: "Makara", debitAccNo: "000482502", creditAccNo: "000483990", icon: "", currency: "KHQR", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "10 Mar 2026, 05:07 PM", amount: 34, txnType: "1021"),
        TransactionModel(txnNoInCbs: "FT260831PH0W", txnRefNo: "FTQR260830810000009", isDebit: true, debitAccName: "Makara71,", accountName: "Makara", debitAccNo: "000482502", creditAccNo: "000483990", icon: "", currency: "KHQR", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "10 Mar 2026, 05:07 PM", amount: 34, txnType: "1021"),
        TransactionModel(txnNoInCbs: "FT260831PH0W", txnRefNo: "FTQR260830810000009", isDebit: true, debitAccName: "Makara71,", accountName: "Makara", debitAccNo: "000482502", creditAccNo: "000483990", icon: "", currency: "KHQR", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "10 Mar 2026, 02:07 PM", amount: 34, txnType: "1021"),
        TransactionModel(txnNoInCbs: "FT260831PH0W", txnRefNo: "FTQR260830810000009", isDebit: true, debitAccName: "Makara71,", accountName: "Makara", debitAccNo: "000482502", creditAccNo: "000483990", icon: "", currency: "KHQR", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "10 Mar 2026, 04:07 PM", amount: 34, txnType: "1021"),
        
        TransactionModel(txnNoInCbs: "FT260831PH0W", txnRefNo: "FTQR260830810000009", isDebit: true, debitAccName: "Makara71,", accountName: "Makara", debitAccNo: "000482502", creditAccNo: "000483990", icon: "", currency: "KHQR", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "09 Feb 2026, 01:35 AM", amount: 34, txnType: "1021"),
        
        TransactionModel(txnNoInCbs: "FT260831PH0W", txnRefNo: "FTQR260830810000009", isDebit: true, debitAccName: "Makara71,", accountName: "Makara", debitAccNo: "000482502", creditAccNo: "000483990", icon: "", currency: "KHQR", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "08 Feb 2026, 01:35 AM", amount: 34, txnType: "1021"),
        
        TransactionModel(txnNoInCbs: "FT260831PH0W", txnRefNo: "FTQR260830810000009", isDebit: true, debitAccName: "Makara71,", accountName: "Makara", debitAccNo: "000482502", creditAccNo: "000483990", icon: "", currency: "KHQR", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "01 Jan 2026, 01:35 AM", amount: 34, txnType: "1021"),
        
        TransactionModel(txnNoInCbs: "FT260831PH0W", txnRefNo: "FTQR260830810000009", isDebit: true, debitAccName: "Makara71,", accountName: "Makara", debitAccNo: "000482502", creditAccNo: "000483990", icon: "", currency: "KHQR", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "01 Jan 2026, 11:35 AM", amount: 34, txnType: "1021"),
        TransactionModel(txnNoInCbs: "FT260831PH0W", txnRefNo: "FTQR260830810000009", isDebit: true, debitAccName: "Makara71,", accountName: "Makara", debitAccNo: "000482502", creditAccNo: "000483990", icon: "", currency: "KHQR", creditAccName: "TBA TEST12", isPayment: false, title: "transfer to testing", txnDescription: "to QR Within Bank", accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==", txnDate: "21 Jan 2026, 11:35 AM", amount: 34, txnType: "1021"),
        
    ]
}


extension TransactionDetailModel {
    static let mockTransactions: [TransactionDetailModel] = [
        TransactionDetailModel(
            txnNoInCbs: "TXN001",
            amount: 120.5,
            currency: "USD",
            date: "2026-04-20",
            status: "SUCCESS",
            description: "Payment to ABA",
            senderAcc: "00023413",
            receiverAcc: "01232111",
            trxNum: "txe20984554",
            AuthNUM: "1200999",
            feeAmount: "0.50"
        ),
        TransactionDetailModel(
            txnNoInCbs: "TXN002",
            amount: 75.0,
            currency: "KHQ",
            date: "2026-03-19",
            status: "PENDING",
            description: "Top up phone",
            senderAcc: "00023413",
            receiverAcc: "01232111",
            trxNum: "txe20984554",
            AuthNUM: "1200999",
            feeAmount: "0.00"
        ),
        TransactionDetailModel(
            txnNoInCbs: "TXN009",
            amount: 200.0,
            currency: "USD",
            date: "2026-04-18",
            status: "FAILED",
            description: "Transfer failed",
            senderAcc: "00023413",
            receiverAcc: "01232111",
            trxNum: "txe20984554",
            AuthNUM: "1200999",
            feeAmount: "0.00"
        )
    ]
}

//TransactionModel(
//    txnNoInCbs: "FT260831PH0W",
//    txnRefNo: "FTQR260830810000009",
//    isDebit: true,
//    debitAccName: "Sopheakneath,",
//    accountName: "Sopheakneath Tester",
//    debitAccNo: "000482502",
//    creditAccNo: "000483990",
//    icon: "",
//    currency: "KHQR",
//    creditAccName: "TBA TEST12",
//    isPayment: false,
//    title: "transfer to Nang",
//    txnDescription: "to QR Within Bank",
//    accountId: "XCvwwOh+5/7JkPHflvtcmUlc9rc6PnpW7g==",
//    txnDate: "24 Mar 2026, 11:37 AM",
//    amount: 50,
//    txnType: "1021"),
