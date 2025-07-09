//
//  ModulePreload.swift
//  Matchermind
//
//  Created by sergemi on 11.10.2024.
//

import Foundation

struct ModulePreload: Identifiable, Equatable, Codable, Hashable {
    let id: String
    var name: String
    var authorId: String
    var isPublic: Bool
    var targetLocaleId: String
    var translateLocaleId: String

    init(id: String, name: String, authorId: String, isPublic: Bool, targetLocaleId: String, translateLocaleId: String) {
        self.id = id
        self.name = name
        self.authorId = authorId
        self.isPublic = isPublic
        self.targetLocaleId = targetLocaleId
        self.translateLocaleId = translateLocaleId
    }
    

    init(name: String, authorId: String, isPublic: Bool, targetLocaleId: String, translateLocaleId: String) {
        self.init(id: UUID().uuidString,
                  name: name,
                  authorId: authorId,
                  isPublic: isPublic,
                  targetLocaleId: targetLocaleId,
                  translateLocaleId: translateLocaleId)
    }
    
    init() {
        self.init(name: "", authorId: "", isPublic: false, targetLocaleId: "", translateLocaleId: "")
    }
}
