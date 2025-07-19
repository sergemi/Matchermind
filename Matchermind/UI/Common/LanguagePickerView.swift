//
//  LanguagePickerView.swift
//  Matchermind
//
//  Created by sergemi on 10/07/2025.
//

import SwiftUI

struct LanguagePickerView: View {
    @Binding var selectedLanguageCode: String
    @Environment(\.dismiss) private var dismiss
    
    @State private var searchText = ""
    
    private var uniqueLanguageCodes: [String] {
        let languageCodes = Locale.availableIdentifiers.compactMap {
            Locale(identifier: $0).language.languageCode?.identifier
        }
        
        // remove dublicates
        let uniqueCodes = Set(languageCodes)
        
        // Sort by locale name
        return uniqueCodes.sorted { lhs, rhs in
            let lhsName = Locale.current.localizedString(forLanguageCode: lhs) ?? ""
            let rhsName = Locale.current.localizedString(forLanguageCode: rhs) ?? ""
            return lhsName.localizedCaseInsensitiveCompare(rhsName) == .orderedAscending
        }
    }
    
    private var filteredLanguageCodes: [String] {
        guard !searchText.isEmpty else { return uniqueLanguageCodes }
        return uniqueLanguageCodes.filter { code in
            Locale.current.localizedString(forLanguageCode: code)?
                .localizedCaseInsensitiveContains(searchText) == true
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredLanguageCodes, id: \.self) { code in
                Button {
                    selectedLanguageCode = code
                    dismiss()
                } label: {
                    HStack {
                        Text(Locale.current.localizedString(forLanguageCode: code) ?? code)
                        Spacer()
                        if code == selectedLanguageCode {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                        }
                    }
                    .foregroundStyle(.primary)
                }
            }
            .searchable(text: $searchText, prompt: "Search for a language")
            .navigationTitle("Select Language")
        }
    }
}

// MARK: - Preview

#Preview {
    LanguagePickerPreviewWrapper()
}

private struct LanguagePickerPreviewWrapper: View {
    @State private var selectedCode: String = "en"
    
    var body: some View {
        Text("Selected language code: \(selectedCode)")
            .sheet(isPresented: .constant(true)) {
                LanguagePickerView(selectedLanguageCode: $selectedCode)
            }
    }
}
