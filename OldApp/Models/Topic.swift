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
    var words: [LearnedWord]
    var exercises: [ExerciseType]
    
    init(id: String, name: String, details: String, words: [LearnedWord], exercises: [ExerciseType]) {
        self.id = id
        self.name = name
        self.details = details
        self.words = words
        self.exercises = exercises
    }
    
    init(name: String, details: String, words: [LearnedWord], exercises: [ExerciseType]) {
        self.init(id: UUID().uuidString,
                  name: name,
                  details: details,
                  words: words,
                  exercises: exercises)
    }
    
    init() {
        self.init(name: "", details: "", words: [], exercises: [])
    }
}

extension Topic {
    var topicPreload:TopicPreload {
        return TopicPreload(id: id,
                            name: name)
    }
}
