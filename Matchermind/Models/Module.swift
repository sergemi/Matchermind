//
//  Module.swift
//  Matchermind
//
//  Created by sergemi on 11.10.2024.
//

import Foundation

struct Module: Identifiable, Equatable, Codable, Hashable {
    let id: String
    
    var name: String
    var details: String
    var topics: [TopicPreload]
    var authorId: String
    var isPublic: Bool
    
    var targetLocaleId: String
    var translateLocaleId: String
    
    init(id: String, name: String, details: String, topics: [TopicPreload], authorId: String, isPublic: Bool, targetLocaleId: String, translateLocaleId: String) {
        self.id = id
        self.name = name
        self.details = details
        self.topics = topics
        self.authorId = authorId
        self.isPublic = isPublic
        self.targetLocaleId = targetLocaleId
        self.translateLocaleId = translateLocaleId
    }
    
    init(name: String = "",
         details: String = "",
         topics: [TopicPreload] = [],
         authorId: String = "",
         isPublic: Bool = false,
         targetLocaleId: String = Locale.currentLanguageCode,
         translateLocaleId: String = Locale.currentLanguageCode) {
        self.init(id: UUID().uuidString,
                  name: name,
                  details: details,
                  topics: topics,
                  authorId: authorId,
                  isPublic: isPublic,
                  targetLocaleId: targetLocaleId,
                  translateLocaleId: translateLocaleId)
    }
}

extension Module {
    var modulePreload: ModulePreload {
        return ModulePreload(id: id,
                             name: name,
                             authorId: authorId,
                             isPublic: isPublic,
                             targetLocaleId: targetLocaleId,
                             translateLocaleId: translateLocaleId)
    }
    
    init(preload: ModulePreload, details: String = "", topics: [TopicPreload] = []) {
        self.id = preload.id
        self.name = preload.name
        self.details = details
        self.topics = topics
        self.authorId = preload.authorId
        self.isPublic = preload.isPublic
        self.targetLocaleId = preload.targetLocaleId
        self.translateLocaleId = preload.translateLocaleId
        
    }
}
