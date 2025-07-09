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
    var targetLocaleId: String
    var translateLocaleId: String
    
    init(id: String, name: String, targetLocaleId: String, translateLocaleId: String) {
        self.id = id
        self.name = name
        self.targetLocaleId = targetLocaleId
        self.translateLocaleId = translateLocaleId
    }
    
    init (name: String, targetLocaleId: String, translateLocaleId: String) {
        self.init(id: UUID().uuidString,
                  name: name, targetLocaleId: targetLocaleId,
                  translateLocaleId: translateLocaleId)
    }
    
    init() {
        self.init(name: "", targetLocaleId: "", translateLocaleId: "")
    }
}
