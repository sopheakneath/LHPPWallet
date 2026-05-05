import Foundation
import SwiftUI
import Combine

final class LocalizationManager: ObservableObject {
    static let shared = LocalizationManager()
    private var translations: [String: String] = [:]
    
    enum Language: String {
        case en
        case kh
       
       
    }

    private let storageKey = "appLanguage"

    @Published private(set) var language: Language

   private init() {
        let raw = UserDefaults.standard.string(forKey: storageKey)
        self.language = Language(rawValue: raw ?? "") ?? .kh
    }

    func toggleLanguage() {
        language = (language == .en) ? .kh : .en
        UserDefaults.standard.set(language.rawValue, forKey: storageKey)
    }
    
//    private func loadLanguage() {
//            guard let path = Bundle.main.path(forResource: language.rawValue, ofType: "json"),
//                  let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
//                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: String] else {
//                print(" Failed to load \(language.rawValue).json")
//                translations = [:]
//                return
//            }
//
//            translations = json
//        }

    func titleForLanguageButton() -> String {
        switch language {
        case .en: return "KH"
        case .kh: return "EN"
        }
    }
    
    func imageForLanguageButton() -> String {
        switch language {
        case .kh: return "ic_language_us"
        case .en: return "ic_language_kh"
        }
    }
    

    func t(_ key: String) -> String {
        let dict: [Language: [String: String]] = [
            .en: Localizations.en,
            .kh: Localizations.kh
        ]

        return dict[language]?[key] ?? key
    }
}

