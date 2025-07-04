//
//  EditTopicsListView.swift
//  Matchermind
//
//  Created by sergemi on 03/07/2025.
//

import SwiftUI

struct EditTopicsListView: View {
    @Binding var topics: [TopicPreload]
    let onAdd: () -> Void
    // onAdd: <#T##() -> Void#>
    var body: some View {
        VStack {
//            EditTopicsListRowHeader(count: topics.count, onAdd: {})
            EditTopicsListRowHeader(count: topics.count, onAdd: onAdd)
            Spacer()
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
            EditTopicsListView(topics: $topics, onAdd: {})
        }
    }
    
    return PreviewWrapper()
}
