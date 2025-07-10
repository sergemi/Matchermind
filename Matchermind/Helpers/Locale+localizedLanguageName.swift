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
}
