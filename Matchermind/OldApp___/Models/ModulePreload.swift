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
    var author: String // author id
    var isPublic: Bool
    

    init(id: String, name: String, author: String, isPublic: Bool) {
        self.id = id
        self.name = name
        self.author = author
        self.isPublic = isPublic
    }
    

    init(name: String, author: String, isPublic: Bool) {
        self.init(id: UUID().uuidString,
                  name: name,
                  author: author,
                  isPublic: isPublic)
    }
    
    init() {
        self.init(name: "", author: "", isPublic: false)
    }
}
