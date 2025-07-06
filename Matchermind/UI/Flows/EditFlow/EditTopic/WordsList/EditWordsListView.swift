//
//  EditWordsListView.swift
//  Matchermind
//
//  Created by sergemi on 05/07/2025.
//

import SwiftUI

struct EditWordsListView: View {
    @Environment(AppRouter.self) var router
    @Binding var words: [WordPair]
    let onAdd: () -> Void
    let onEdit: (_ id: String) -> Void
    
    var body: some View {
        VStack {
            EditWordsListRowHeader(count: words.count, onAdd: onAdd)
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 8) {
                    ForEach(words) { word in
                        Button {
                            print(word.id)
                            onEdit(word.id)
                        } label: {
                            EditWordsListRow(wordPair: word)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
}

//#Preview {
//    struct PreviewWrapper: View {
//        @State private var words: [WordPair] = [
//            WordPair(target: "Bebe", translate: "Пить"),
//            WordPair(target: "Leche", translate: "Молоко")
//        ]
//        
//        var body: some View {
//            EditWordsListView(words: $words, onAdd: {})
//        }
//    }
//    
//    return PreviewWrapper()
//}
