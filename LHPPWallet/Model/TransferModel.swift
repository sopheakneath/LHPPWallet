//
//  TransferModel.swift
//  LHPPWallet
//
//  Created by sopheakneath on 10/4/26.
//
import Combine
import SwiftUI
import Foundation

struct walletListModel: Codable {
    let image : String
    let title : String
}

class TransferSevice {
    static let shared = TransferSevice()
    func getWalletList(completion: @escaping ([walletListModel]) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.init(walletListModel.mockList))
        }}
}


extension walletListModel {
    static let mockList : [walletListModel] = [
        walletListModel(image: "logo", title: "Ly Hour"),
        walletListModel(image: "bakong", title: "Pay Pay "),
        walletListModel(image: "Ly hour", title: "U Pay"),
        walletListModel(image: "Ly hour", title: "Bakong"),
        walletListModel(image: "Ly hour", title: "Bakong"),
        walletListModel(image: "Ly hour", title: "Bakong"),
        walletListModel(image: "Ly hour", title: "Bakong"),
    ]
    
}
