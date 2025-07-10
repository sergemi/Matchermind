//
//  LanguagePickerView.swift
//  Matchermind
//
//  Created by sergemi on 10/07/2025.
//

import SwiftUI

struct LanguagePickerView: View {
    @Binding var selectedLocaleId: String
    @Environment(\.dismiss) private var dismiss
    
    @State private var searchText = ""
    
    private var allLocaleIds: [String] {
        Locale.availableIdentifiers
            .filter { id in
                guard let name = Locale.current.localizedString(forIdentifier: id) else { return false }
                return !name.trimmingCharacters(in: .whitespaces).isEmpty
            }
            .sorted { lhs, rhs in
                Locale.current.localizedString(forIdentifier: lhs)?.localizedCaseInsensitiveCompare(
                    Locale.current.localizedString(forIdentifier: rhs) ?? ""
                ) == .orderedAscending
            }
    }
    
    private var filteredLocaleIds: [String] {
        guard !searchText.isEmpty else { return allLocaleIds }
        return allLocaleIds.filter {
            Locale.current.localizedString(forIdentifier: $0)?
                .localizedCaseInsensitiveContains(searchText) == true
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredLocaleIds, id: \.self) { id in
                Button {
                    selectedLocaleId = id
                    dismiss()
                } label: {
                    HStack {
                        Text(Locale.current.localizedString(forIdentifier: id) ?? id)
                        Spacer()
                        if id == selectedLocaleId {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Select Language")
        }
    }
}

//#Preview {
//    LanguagePickerPreviewWrapper()
//}
//
//private struct LanguagePickerPreviewWrapper: View {
//    @State private var locale = Locale.current
//
//    var body: some View {
//        LanguagePickerView(selectedLocale: $locale)
//    }
//}
