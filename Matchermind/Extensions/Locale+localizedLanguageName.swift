//
//  Locale+localizedLanguageName.swift
//  Matchermind
//
//  Created by sergemi on 10/07/2025.
//

import Foundation

extension Locale {
    var localizedLanguageName: String? {
        guard let languageCode = self.language.languageCode?.identifier else { return nil }
        return self.localizedString(forLanguageCode: languageCode)?.capitalized
    }
    
    func localizedLanguageName(for identifier: String) -> String? {
        let locale = Locale(identifier: identifier)
        guard let languageCode = locale.language.languageCode?.identifier else { return nil }
        return self.localizedString(forLanguageCode: languageCode)?.capitalized
    }
    
    static var currentLanguageCode: String {
        Locale.current.language.languageCode?.identifier ?? "en"
    }
}
