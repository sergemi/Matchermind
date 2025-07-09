//
//  Topic.swift
//  Matchermind
//
//  Created by sergemi on 11.10.2024.
//

import Foundation

struct Topic: Identifiable, Equatable, Codable {
    let id: String
    
    var name: String
    var details: String
    var words: [WordPair]
    @CodableSetAsArray var exercises: Set<ExerciseType>
    
    var targetLocaleId: String
    var translateLocaleId: String
    
    init(id: String, name: String, details: String, words: [WordPair], exercises: Set<ExerciseType>, targetLocaleId: String, translateLocaleId: String) {
        self.id = id
        self.name = name
        self.details = details
        self.words = words
        self.exercises = exercises
        self.targetLocaleId = targetLocaleId
        self.translateLocaleId = translateLocaleId
    }
    
    init(name: String, details: String, words: [WordPair], exercises: Set<ExerciseType>, targetLocaleId: String, translateLocaleId: String) {
        self.init(id: UUID().uuidString,
                  name: name,
                  details: details,
                  words: words,
                  exercises: exercises,
                  targetLocaleId: targetLocaleId,
                  translateLocaleId: translateLocaleId)
    }
    
    init() {
        self.init(name: "", details: "", words: [], exercises: [],
                  targetLocaleId: "", translateLocaleId: "") // TODO: Init by current locale)
    }
}

extension Topic {
    var topicPreload:TopicPreload {
        return TopicPreload(id: id,
                            name: name,
                            targetLocaleId: targetLocaleId,
                            translateLocaleId: translateLocaleId)
    }
}
