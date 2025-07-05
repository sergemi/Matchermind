//
//  EditWordsListRow.swift
//  Matchermind
//
//  Created by sergemi on 03/07/2025.
//

import SwiftUI

struct EditWordsListRow: View {
    let wordPair: WordPair
    
    var body: some View {
        HStack {
            Text("\(wordPair.target) - \(wordPair.translate)")
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
}

#Preview {
    let wordPair = WordPair(target: "Hello", translate: "Bonjour")
    
    EditWordsListRow(wordPair: wordPair)
}
