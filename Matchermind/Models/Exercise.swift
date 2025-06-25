//
//  Exercise.swift
//  Matchermind
//
//  Created by sergemi on 11.10.2024.
//

import Foundation

enum ExerciseType: String, Equatable, Codable {
    case choseTranslate
    case choseTranslateInverse
    case writeTranslate
    case writeTranslateInverse
    case swapLettersTranslate
    case swapLettersTranslateInverse
}

struct Exercise: Identifiable, Equatable, Codable {
    let id: String
    
    var type: ExerciseType
    var maxScore: Int
//    var correct: Int = 0 //TODO: remove?
//    var incorrect: Int = 0
    
    init(id: String, type: ExerciseType, maxScore: Int) {
        self.id = id
        self.type = type
        self.maxScore = maxScore
    }
    
    init(type: ExerciseType, maxScore: Int) {
        self.init(id: UUID().uuidString,
                  type: type,
                  maxScore: maxScore)
    }
    
    init() {
        print("TODO: Exercise better init by concrete type")
        self.init(type: .choseTranslate, maxScore: 0)
    }
}
