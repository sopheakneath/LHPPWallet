import Foundation

struct Localizations {
    private static var cache: [String: [String: String]] = [:]

    private static func loadJSON(named name: String) -> [String: String] {
        if let cached = cache[name] { return cached }
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            return [:]
        }
        do {
            let data = try Data(contentsOf: url)
            let dict = try JSONDecoder().decode([String: String].self, from: data)
            cache[name] = dict
            return dict
        } catch {
            return [:]
        }
    }

    static var en: [String: String] { loadJSON(named: "en") }
    static var kh: [String: String] { loadJSON(named: "kh") }

    static var map: [LocalizationManager.Language: [String: String]] {
        [
            .en: en,
            .kh: kh
        ]
    }
}
