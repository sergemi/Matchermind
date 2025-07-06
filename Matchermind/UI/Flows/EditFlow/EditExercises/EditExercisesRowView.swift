//
//  EditExercisesRowView.swift
//  Matchermind
//
//  Created by sergemi on 05/07/2025.
//

import SwiftUI

struct EditExercisesRowView: View {
    let checked: Bool
    let type: ExerciseType
    var body: some View {
        HStack {
            Image(systemName: checked ? "checkmark.square" : "square")
//                .foregroundColor(.accentColor)
            Text(type.rawValue)
            Spacer()
        }
    }
}

#Preview {
    EditExercisesRowView(checked: true, type: .choseTranslate)
}
