//
//  LearnedWord.swift
//  Matchermind
//
//  Created by sergemi on 11.10.2024.
//

import Foundation
// TODO: maybe need refactoring
struct LearnedWord: Identifiable, Equatable, Codable {
    let id: String
    
    var word: WordPair
    var exercises: [Exercise]
    
    init (id: String, word: WordPair, exercises: [Exercise]) {
        self.id = id
        self.word = word
        self.exercises = exercises
    }
    
    init (word: WordPair, exercises: [Exercise]) {
        self.init(id: UUID().uuidString,
                  word: word,
                  exercises: exercises)
    }
    
    init() {
        self.init(word: WordPair(), exercises: [])
    }
}
