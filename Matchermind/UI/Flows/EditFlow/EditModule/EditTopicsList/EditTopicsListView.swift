//
//  EditTopicsListView.swift
//  Matchermind
//
//  Created by sergemi on 03/07/2025.
//

import SwiftUI

struct EditTopicsListView: View {
    @Environment(AppRouter.self) var router
    @Binding var topics: [TopicPreload]
    let moduleId: String
    let onAdd: () -> Void
    
    @State private var indexSetToDelete: IndexSet? = nil
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        List {
            EditTopicsListRowHeader(count: topics.count, onAdd: onAdd)
                .listRowInsets(.init())
            
            ForEach(topics) { topic in
                Button {
                    router.navigate(to: .edit(.editTopic(moduleId: moduleId, topicId: topic.id)))
                } label: {
                    EditTopicsListRow(topicPreload: topic)
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
            "Are you sure you want to delete this topic?",
            isPresented: $showDeleteConfirmation,
            titleVisibility: .visible
        ) {
            Button("Delete", role: .destructive) {
                if let indexSetToDelete {
                    topics.remove(atOffsets: indexSetToDelete)
                }
            }
            Button("Cancel", role: .cancel) {
                indexSetToDelete = nil
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var topics: [TopicPreload] = [
            TopicPreload(id: "1", name: "Topic 1"),
            TopicPreload(id: "2", name: "Topic 2")
        ]
        
        var body: some View {
            EditTopicsListView(topics: $topics, moduleId: "1", onAdd: {})
        }
    }
    
    return PreviewWrapper()
}
