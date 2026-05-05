//
//  AppError.swift
//  LHPPWallet
//
//  Created by Sopheakneath on 4/4/26.
//

enum AppError: Error {
    case noInternetConnection
    case noData
    case invalidData
    case unknown

    var localizedDescription: String {
        switch self {
        case .noInternetConnection:
            return "No internet connection"
        case .noData:
            return "No data"
        case .invalidData:
            return "Invalid data"
        case .unknown:
            return "Unknown error"
        }
    }
}
