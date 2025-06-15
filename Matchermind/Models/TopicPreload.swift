//
//  TopicPreload.swift
//  Matchermind
//
//  Created by sergemi on 11.10.2024.
//

import Foundation

struct TopicPreload: Identifiable, Equatable, Codable {
    let id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    init (name: String) {
        self.init(id: UUID().uuidString,
                  name: name)
    }
    
    init() {
        self.init(name: "")
    }
}
