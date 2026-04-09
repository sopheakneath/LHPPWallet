//
//  String.swift
//  LHPPWallet
//
//  Created by sopheakneath on 8/4/26.
//


extension String {
    var localized: String {
        LocalizationManager.shared.t(self)
    }
}



extension String {
    func toKhmerNumber() -> String {
        let khmerDigits: [Character: Character] = [
            "0": "០", "1": "១", "2": "២", "3": "៣", "4": "៤",
            "5": "៥", "6": "៦", "7": "៧", "8": "៨", "9": "៩"
        ]
        
        return self.map { khmerDigits[$0] ?? $0 }.map { String($0) }.joined()
    }
}
