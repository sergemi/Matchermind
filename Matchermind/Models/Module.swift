//
//  Module.swift
//  Matchermind
//
//  Created by sergemi on 11.10.2024.
//

import Foundation

struct Module: Identifiable, Equatable, Codable {
    let id: String
    
    var name: String
    var details: String
    var topics: [TopicPreload]
    var authorId: String
    var isPublic: Bool
    
    init(id: String, name: String, details: String, topics: [TopicPreload], authorId: String, isPublic: Bool) {
        self.id = id
        self.name = name
        self.details = details
        self.topics = topics
        self.authorId = authorId
        self.isPublic = isPublic
    }
    
    init(name: String, details: String, topics: [TopicPreload], authorId: String, isPublic: Bool) {
        self.init(id: UUID().uuidString,
                  name: name,
                  details: details,
                  topics: topics,
                  authorId: authorId,
                  isPublic: isPublic)
    }
    
    init() {
        self.init(name: "", details: "", topics: [], authorId: "", isPublic: false)
    }
}

extension Module {
    var modulePreload: ModulePreload {
        let topicIds = topics.map { $0.id }
        return ModulePreload(id: id,
                             name: name,
                             authorId: authorId,
                             isPublic: isPublic)
    }
}
