//
//  TopicPickerView.swift
//  Matchermind
//
//  Created by sergemi on 11/07/2025.
//

import SwiftUI

struct TopicPickerView: View {
    let topics: [TopicPreload]
    let selected: TopicPreload?
    let onSelect: (TopicPreload) -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List(topics) { topic in
                Button {
                    onSelect(topic)
                    dismiss()
                } label: {
                    HStack {
                        Text(topic.name)
                        if selected?.id == topic.id {
                            Spacer()
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationTitle("Select topic")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    let topics: [TopicPreload] = [
        TopicPreload(name: "Topic 1", targetLocaleId: "", translateLocaleId: ""),
        TopicPreload(name: "Topic 2", targetLocaleId: "", translateLocaleId: ""),
        TopicPreload(name: "Topic 3", targetLocaleId: "", translateLocaleId: ""),
        TopicPreload(name: "Topic 4", targetLocaleId: "", translateLocaleId: ""),
        TopicPreload(name: "Topic 5", targetLocaleId: "", translateLocaleId: ""),
    ]
    
    TopicPickerView(topics: topics,
                    selected: topics.first,
                    onSelect: {_ in })
}
