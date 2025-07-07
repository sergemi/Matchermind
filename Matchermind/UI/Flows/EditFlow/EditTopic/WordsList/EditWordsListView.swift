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
        List() {
            EditWordsListRowHeader(count: words.count, onAdd: onAdd)
                .listRowInsets(.init())
            
            ForEach(words) { word in
                Button {
                    print(word.id)
                    onEdit(word.id)
                } label: {
                    EditWordsListRow(wordPair: word)
                        .contentShape(Rectangle())
                }
                .buttonStyle(PlainButtonStyle())
                .listRowInsets(.init())
            }
            .onDelete(perform: deleteItems)
        }
        .listStyle(.plain)
    }
    
    private func deleteItems(at offsets: IndexSet) {
        words.remove(atOffsets: offsets)
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
