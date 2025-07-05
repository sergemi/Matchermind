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
    
    var body: some View {
        VStack {
            EditTopicsListRowHeader(count: topics.count, onAdd: onAdd)
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 8) {
                    ForEach(topics) { topic in
                        Button {
                            print(topic.id)
                            router.navigate(to: .edit(.editTopic(moduleId: moduleId, topicId: topic.id)))
                        } label: {
                            EditTopicsListRow(topicPreload: topic)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
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
