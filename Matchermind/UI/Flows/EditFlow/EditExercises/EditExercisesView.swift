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
        VStack {
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
            HStack {
                Button("Select all", action: {
                    Task {
                        await MainActor.run {
                            exercises = Set(ExerciseType.allCases)
                        }
                    }
                })
                .frame(maxWidth: .infinity)
                .layoutPriority(1)
//                .buttonStyle(.bordered)
                
                Button("Clear all", action: {
                    Task {
                        await MainActor.run {
                            exercises.removeAll()
                        }
                    }
                })
                .frame(maxWidth: .infinity)
                .layoutPriority(1)
                .tint(.red)
//                .buttonStyle(.bordered)
            }
        }
    }
}

#Preview {
    EditExercisesView(exercises: .constant([.choseTranslate, .writeTranslate]))
}
