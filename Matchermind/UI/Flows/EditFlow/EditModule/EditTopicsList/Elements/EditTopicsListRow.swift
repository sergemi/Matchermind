//
//  EditTopicsListRow.swift
//  Matchermind
//
//  Created by sergemi on 03/07/2025.
//

import SwiftUI

struct EditTopicsListRow: View {
    let topicPreload: TopicPreload
    
    var body: some View {
        HStack {
            Text(topicPreload.name)
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
}

#Preview {
    let topic = Topic(name: "Topic",
                      details: "Topic details",
                      words: [],
                      exercises: [],
                      targetLocaleId: "", // TODO: Add real
                      translateLocaleId: "")
    let topicPreload = topic.topicPreload
    
    EditTopicsListRow(topicPreload: topicPreload)
}
