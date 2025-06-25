//
//  ModulePreload.swift
//  Matchermind
//
//  Created by sergemi on 11.10.2024.
//

import Foundation

struct ModulePreload: Identifiable, Equatable, Codable {
    let id: String
    var name: String
    var authorId: String
    var isPublic: Bool
    

    init(id: String, name: String, authorId: String, isPublic: Bool) {
        self.id = id
        self.name = name
        self.authorId = authorId
        self.isPublic = isPublic
    }
    

    init(name: String, authorId: String, isPublic: Bool) {
        self.init(id: UUID().uuidString,
                  name: name,
                  authorId: authorId,
                  isPublic: isPublic)
    }
    
    init() {
        self.init(name: "", authorId: "", isPublic: false)
    }
}
