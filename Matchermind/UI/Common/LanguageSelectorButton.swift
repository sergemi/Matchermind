//
//  LanguageSelectorButton.swift
//  Matchermind
//
//  Created by sergemi on 10/07/2025.
//

import SwiftUI

struct LanguageSelectorButton: View {
    let title: String
    @Binding var selectedLocaleId: String
    
    @State private var showPicker = false
    
    var body: some View {
        Button {
            showPicker = true
        } label: {
            HStack {
                Text(title)
                    .foregroundColor(.primary)
                Spacer()
                HStack(spacing: 4) {
                    Text(Locale.current.localizedString(forIdentifier: selectedLocaleId) ?? "Select")
                        .foregroundColor(.accentColor)
                    Image(systemName: "chevron.down")
                        .font(.subheadline)
                        .foregroundColor(.accentColor)
                }
            }
            .contentShape(Rectangle())
        }
        .sheet(isPresented: $showPicker) {
            LanguagePickerView(selectedLocaleId: $selectedLocaleId)
        }
    }
}

#Preview {
    @Previewable @State var selectedLocaleId = "en"
    
    return VStack(spacing: 20) {
        LanguageSelectorButton(title: "Target Language:",
                               selectedLocaleId: $selectedLocaleId)
        
    }
    .padding()
}
