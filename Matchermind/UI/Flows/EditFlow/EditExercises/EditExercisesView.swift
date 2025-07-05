//
//  EditExercisesView.swift
//  Matchermind
//
//  Created by sergemi on 05/07/2025.
//

import SwiftUI

struct EditExercisesView: View {
    @Binding var exercises: Set<ExerciseType>
    
    var body: some View {
        List(ExerciseType.allCases, id: \.self) { type in
            Button {
                if exercises.contains(type) {
                    exercises.remove(type)
                }
                else {
                    exercises.insert(type)
                }
            } label: {
                EditExercisesRowView(checked: exercises.contains(type),
                                     type: type)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    EditExercisesView(exercises: .constant([.choseTranslate, .writeTranslate]))
}
