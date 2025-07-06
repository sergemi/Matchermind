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
        List {
            Section {
                ForEach(ExerciseType.allCases, id: \.self) { type in
                    Button {
                        if exercises.contains(type) {
                            exercises.remove(type)
                        } else {
                            exercises.insert(type)
                        }
                    } label: {
                        EditExercisesRowView(checked: exercises.contains(type),
                                             type: type)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            } footer: {
                HStack {
                    Button("Select all") {
                        exercises = Set(ExerciseType.allCases)
                    }
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.bordered)
                    
                    Button("Clear all") {
                        exercises.removeAll()
                    }
                    .frame(maxWidth: .infinity)
                    .tint(.red)
                    .buttonStyle(.bordered)
                }
                .padding(.top)
            }
        }
        .navigationTitle("Select exercises")
    }
}

#Preview {
    EditExercisesView(exercises: .constant([.choseTranslate, .writeTranslate]))
}
