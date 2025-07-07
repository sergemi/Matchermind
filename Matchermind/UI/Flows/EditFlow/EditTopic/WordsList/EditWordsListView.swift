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
    
    @State private var indexSetToDelete: IndexSet? = nil
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        List {
            EditWordsListRowHeader(count: words.count, onAdd: onAdd)
                .listRowInsets(.init())
            
            ForEach(words) { word in
                Button {
                    onEdit(word.id)
                } label: {
                    EditWordsListRow(wordPair: word)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .listRowInsets(.init())
            }
            .onDelete { indexSet in
                indexSetToDelete = indexSet
                showDeleteConfirmation = true
            }
        }
        .listStyle(.plain)
        .confirmationDialog(
            "Are you sure you want to delete this word?",
            isPresented: $showDeleteConfirmation,
            titleVisibility: .visible
        ) {
            Button("Delete", role: .destructive) {
                if let indexSetToDelete {
                    words.remove(atOffsets: indexSetToDelete)
                }
            }
            Button("Cancel", role: .cancel) {
                indexSetToDelete = nil
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
