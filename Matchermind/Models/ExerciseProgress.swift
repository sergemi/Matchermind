//
//  ExerciseProgress.swift
//  Matchermind
//
//  Created by sergemi on 19/06/2025.
//

import Foundation

struct ExerciseProgress: Identifiable, Codable {
    let id: String
    let exerciseId: String
    var correct: Int
    var incorrect: Int
    
    init(id: String, exerciseId: String, correct: Int, incorrect: Int) {
        self.id = id
        self.exerciseId = exerciseId
        self.correct = correct
        self.incorrect = incorrect
    }
    
    init(exerciseId: String, correct: Int, incorrect: Int) {
        self.init(id: UUID().uuidString,
                  exerciseId: exerciseId,
                  correct: correct,
                  incorrect: incorrect)
    }
}
